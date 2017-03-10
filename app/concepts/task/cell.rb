class Task
  class Cell < Cell::Concept
    include ::Cell::Hamlit

    def show
      render
    end
  end
end
