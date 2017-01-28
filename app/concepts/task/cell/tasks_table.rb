class Task
  class Cell
    class TasksTable < ::Cell::Concept
      inherit_views Task::Cell
      include ActionView::Helpers::DateHelper

      delegate :can_delete?, :can_edit?, :can_share?, :creator?, to: :user_task_policy
      delegate :creator, :updated_at, :id, :text, to: :model
      delegate :email, to: :creator, prefix: true

      def show
        render :tasks_table
      end

      def clearfix
        content_tag(:div, nil, class: 'clearfix')
      end

      def user
        @user ||= params[:current_user]
      end

      def title
        creator? ? 'My task' : creator_email
      end

      def create_date
        "#{time_ago_in_words(updated_at)} ago"
      end

      def task_block_id
        "task-#{id}"
      end

      def delete_link
        return unless can_delete?
        link_to task_path(id), remote: true, method: 'delete', class: 'pull-right' do
          content_tag(:i, nil, class: 'fa fa-remove')
        end
      end

      def edit_link
        return unless can_edit?
        link_to render_modal_tasks_path(id: id, target: 'edit'), data: { target: '#tasks-modal', toggle: 'modal' }, remote: true, method: 'get' do
          content_tag(:i, nil, class: 'fa fa-pencil')
        end
      end

      def share_link
        return unless can_share?
        link_to render_modal_tasks_path(id: id, target: 'share'), data: { target: '#tasks-modal', toggle: 'modal' }, remote: true, method: 'get' do
          content_tag(:i, nil, class: 'fa fa-share')
        end
      end

      private

      def user_task_policy
        @user_task_policy ||= UserTaskPolicy.new(user, @model)
      end
    end
  end
end
