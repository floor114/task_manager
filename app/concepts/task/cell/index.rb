class Task
  class Cell
    class Index < ::Cell::Concept
      inherit_views Task::Cell

      def show
        render :index
      end

      def tasks_table_block
        @model.empty? ? tasks_not_found : tasks_table
      end

      def tasks_not_found
        content_tag(:h4, 'There are no tasks.', class: 'text-xs-center tasks-empty')
      end

      def tasks_table
        concept('task/cell/tasks_table', collection: @model)
      end
    end
  end
end
