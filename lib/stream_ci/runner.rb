module StreamCi
  class Runner
    def initialize(runner)
      @runner = runner.to_s
      @errors = []
      validate
    end

    attr_reader :errors

    def invoke
      # we might need to create method aliases for other test suites.
      # rspec happens to use `invoke`. The others might not.
      # Other classes might not even have this as a class method...
      # need to investigate further...
      runner_klass.invoke if valid?
    end

    def valid?
      errors.none?
    end

    private

    def validate
      errors << missing_message and return if runner_missing?
      errors << unavailable_message if runner_unavailable?
    end

    def runner_missing?
      @runner.length == 0
    end

    def runner_unavailable?
      !Object.const_defined?(klass_root + parsed_runner)
    end

    def missing_message
      'no runner given'
    end

    def unavailable_message
      "'#{@runner}' (#{full_klass}) runner is not defined."
    end

    def full_klass
      klass_root + parsed_runner
    end

    def runner_klass
      Object.const_get full_klass
    end

    def parsed_runner
      @runner.split(/[^a-zA-Z\d]/).map { |ww| ww.downcase.capitalize }.join
    end

    def klass_root
      'StreamCi::Runners::'
    end
  end
end
