require 'minitest/autorun'
require 'fileutils'
require 'open3'
require 'tmpdir'

class TreegTest < Minitest::Test
  TREEG = File.expand_path( '../treeg', __dir__ )

  def test_skips_empty_nested_git_directory
    Dir.mktmpdir( 'treeg-test' ) do |tmpdir|
      repo = File.join( tmpdir, 'repo' )
      nested_git = File.join( repo, 'tools', 'copy', '.git' )
      Dir.mkdir( repo )
      system( 'git', 'init', '--quiet', repo, exception: true )
      File.write( File.join( repo, 'README.md' ), "fixture\n" )
      system( 'git', '-C', repo, 'add', 'README.md', exception: true )
      system(
        'git', '-C', repo,
        '-c', 'user.name=Treeg Test',
        '-c', 'user.email=treeg@example.invalid',
        'commit', '--quiet', '-m', 'Initial commit',
        exception: true
      )
      File.write( File.join( repo, 'README.md' ), "dirty fixture\n" )
      File.write( File.join( repo, '.git', 'FETCH_HEAD' ), '' )
      FileUtils.mkdir_p( nested_git )

      validated_git_dir, validation_error, validation_status = Open3.capture3(
        'git',
        '-c', 'core.fsmonitor=',
        "--git-dir=#{ File.join( repo, '.git' ) }",
        'rev-parse', '--git-dir'
      )
      assert_predicate validation_status, :success?, validation_error
      assert_equal File.join( repo, '.git' ), validated_git_dir.chomp

      executable = File.join( tmpdir, "treeg-test-#{ Process.pid }" )
      File.symlink( TREEG, executable )

      output, error, status = Open3.capture3( executable, repo )
      plain_output = output.gsub( /\e\[[\d;]*m/, '' )

      assert_predicate status, :success?, error
      assert_includes plain_output, "Skipping #{ nested_git } (not a git repository)"
      assert_equal 1, plain_output.lines.count { |line| line.include?( "#{ repo }:" ) and line.include?( '✜' ) }, plain_output
    end
  end
end
