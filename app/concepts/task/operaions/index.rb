class Task
  class Index < ::Trailblazer::Operation
    def process(options)
      @model = options[:current_user].tasks
    end
  end
end
