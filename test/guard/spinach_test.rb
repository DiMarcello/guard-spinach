require_relative '../test_helper'

describe Guard::Spinach do
  subject { Guard::Spinach.new(data, options) }
  let(:paths) { %w(fake/path.feature foo/bar.feature) }
  let(:data) { [] }
  let(:options) { {} }

  describe "#run_on_change" do
    let(:changed) { %w(fake/path.feature) }
    it "fires run on a runner" do
      Guard::Spinach::Runner.any_instance.expects(:system).with("spinach #{changed.join " "}")
      subject.run_on_change(changed)
    end

    describe "with cli" do
      let(:options) { {:cli => "--generate"} }

      it "fires run on a runner" do
        Guard::Spinach::Runner.any_instance.expects(:system).with("spinach --generate #{changed.join " "}")
        subject.run_on_change(changed)
      end
    end
  end

  describe "#run_all" do
    it "fires run on a runner" do
      Guard::Spinach::Runner.any_instance.expects(:system).with("spinach ")
      subject.run_all
    end

    describe "with cli" do
      let(:options) { {:cli => "--generate"} }

      it "fires run on a runner" do
        Guard::Spinach::Runner.any_instance.expects(:system).with("spinach --generate")
        subject.run_all
      end
    end
  end

  describe "#start" do
    describe "with defaults" do
      it "does not fire run on a runner" do
        Guard::Spinach::Runner.any_instance.expects(:system).never
        subject.start
      end
    end

    describe "with all_on_start => true" do
      let(:options) { {:all_on_start => true} }

      it "fires run on a runner" do
        Guard::Spinach::Runner.any_instance.expects(:system).with("spinach ")
        subject.start
      end

      describe "with cli => '--generate'" do
        let(:options) { {:all_on_start => true, :cli => "--generate"} }

        it "fires run on a runner" do
          Guard::Spinach::Runner.any_instance.expects(:system).with("spinach --generate")
          subject.start
        end
      end
    end
  end

end
