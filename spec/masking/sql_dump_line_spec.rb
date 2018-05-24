require "masking/sql_dump_line"

RSpec.describe Masking::SQLDumpLine do
  describe '#output' do
    subject { described_class.new(line).output }

    shared_examples 'should same with line' do
      it { is_expected.to eq line }
    end

    context "when line is NOT data line" do
      context "empty" do
        let(:line) { "" }

        it_behaves_like 'should same with line'
      end

      context "headline" do
        let(:line) { %Q|-- MySQL dump 10.13  Distrib 5.7.21, for osx10.13 (x86_64)| }

        it_behaves_like 'should same with line'
      end

      context "metadata" do
        let(:line) { %Q|/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;| }

        it_behaves_like 'should same with line'
      end

      context "DDL" do
        let(:line) { %Q|DROP TABLE IF EXISTS `users`;| }

        it_behaves_like 'should same with line'
      end
    end

    context "when line is insert statement" do
      let(:line) { sql_insert_statement_fixture }

      it 'call Dataline' do
        expect(Masking::DataMaskProcessor).to receive(:process).with(line)

        expect { subject }.not_to raise_error
      end
    end

    describe '#insert_statement?' do
      subject { described_class.new(line).send(:insert_statement?) }

      context "when line is NOT insert statement" do
        context "empty" do
          let(:line) { "" }

          it { is_expected.to eq false }
        end

        context "headline" do
          let(:line) { %Q|-- MySQL dump 10.13  Distrib 5.7.21, for osx10.13 (x86_64)| }

          it { is_expected.to eq false }
        end
      end

      context "when line is insert statement" do
        let(:line) { sql_insert_statement_fixture }

        it { is_expected.to eq true }
      end
    end
  end
end
