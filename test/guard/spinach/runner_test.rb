require_relative '../../test_helper'

describe Guard::Spinach::Runner do
  subject { Guard::Spinach::Runner.new(paths) }
  let(:paths) { %w(fake/path.feature foo/bar.feature) }

  describe "#initialize" do
    it "sets up a bunch of file paths" do
      subject.paths.must_include 'fake/path.feature'
      subject.paths.must_include 'foo/bar.feature'
    end
  end

  describe "#run_command" do
    it "generates a valid run command" do
      subject.run_command.must_equal "spinach fake/path.feature foo/bar.feature"
    end
  end

  describe "#run" do
    it "runs spinach on all the features in the list" do
      subject.expects(:system).with("spinach fake/path.feature foo/bar.feature")
      subject.run
    end

    it "outputs a message" do
      subject.stubs(:system)
      Guard::UI.expects(:info).with("Running fake/path.feature foo/bar.feature", :reset => true)
      subject.run
    end
  end

  describe "with cli option" do
    subject { Guard::Spinach::Runner.new(paths, cli: '--generate') }

    describe "#initialize" do
      it "sets the cli option" do
        subject.options.key?(:cli).must_equal true
        subject.options[:cli].must_equal '--generate'
      end
    end

    describe "#run_command" do
      it "generates a valid run command" do
        subject.run_command.must_equal "spinach --generate fake/path.feature foo/bar.feature"
      end
    end
  end

end
