describe StreamCi::Runner do
  it 'is versioned' do
    expect(StreamCi::Runner::VERSION).to be_a String
  end

  describe '#initialize' do
    context 'when initialized with a runner' do
      context 'and when corresponding runner class is not defined' do
        it 'provides an error message' do
          runner = StreamCi::Runner.new('fake_framework')
          klass = 'StreamCi::FakeFramework::Runner'
          error_messsage = "'fake_framework' (#{klass}) runner is not defined."
          expect(runner.errors).to contain_exactly error_messsage
        end
      end
    end

    context 'when initialized without a runner' do
      it 'provides error messages' do
        runner = StreamCi::Runner.new(nil)
        error_messsage = 'no runner given'
        expect(runner.errors).to contain_exactly error_messsage
      end
    end
  end

  describe '#invoke' do
    context 'when initialized with a runner' do
      context 'and when corresponding runner class is defined' do
        it 'sends `invoke` to that runner' do
          stub_const 'StreamCi::FakeFramework::Runner', Class.new
          StreamCi::FakeFramework::Runner.class_eval do
            def self.invoke; end
          end

          expect(StreamCi::FakeFramework::Runner).to receive(:invoke)
          StreamCi::Runner.new('fake_framework').invoke
        end
      end

      context 'and when corresponding runner class is not defined' do
        it 'returns `nil`' do
          runner = StreamCi::Runner.new('fake_framework')
          expect(runner.invoke).to be_nil
        end
      end
    end

    context 'when initialized without a runner' do
      it 'returns `nil`' do
        runner = StreamCi::Runner.new(nil)
        expect(runner.invoke).to be_nil
      end
    end
  end
end
