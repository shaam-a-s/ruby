KANBAN LIKE TASK MANAGEMENT-Projects(name, description) tasks(name, status(ongoing, todo, conpleted), priority, project_id) apdinu 2 models, each project has many tasks and each task belong to a project. Suitable constraint for colunms like staus and priority using models. Using controllers implement CRUD operations on both models. We should be able to filter tasked based on its status. 3column based on status and in the UI we should be able to drag and drop tasks from one status to another.

rails new kanban --database=sqlite3
cd kanban
bundle install
rails db:create
rails g model Project name:string description:text
rails g model Task name:string status:string priority:string project:references
rails db:migrate
rails g controller Projects
rails g controller Tasks

#config/routes

Rails.application.routes.draw do
  resources :projects do
    resources :tasks
  end
  root "projects#index"
end


#app/models/project.rb

class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
end


#app/models/task.rb

class Task < ApplicationRecord
  belongs_to :project

  STATUSES = %w[todo ongoing completed]
  PRIORITIES = %w[low medium high]

  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }
  validates :name, presence: true
end

#app/controllers/projects.rb

class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def destroy
    project = Project.find_by(id: params[:id])

    if project
        project.destroy
        redirect_to projects_path
    else
        redirect_to projects_path, alert: "Project not found"
    end
  end
  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end

#app/controllers/tasks.rb

class TasksController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)

    if @task.save
      redirect_to @project
    else
      render 'projects/show'
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update(status: params[:task][:status])
    head :ok
  end

  def destroy
    task = Task.find(params[:id])
    project = task.project
    task.destroy
    redirect_to project
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :priority)
  end
end

#app/javascript/application.js

document.addEventListener("DOMContentLoaded", () => {
  let dragged = null;

  document.querySelectorAll(".task").forEach(task => {
    task.addEventListener("dragstart", () => {
      dragged = task;
      task.style.opacity = "0.5";
    });

    task.addEventListener("dragend", () => {
      dragged = null;
      task.style.opacity = "1";
    });
  });

  document.querySelectorAll(".column").forEach(column => {
    column.addEventListener("dragover", e => {
      e.preventDefault();
    });

    column.addEventListener("drop", () => {
      if (!dragged) return;

      column.appendChild(dragged);

      const taskId = dragged.dataset.id;
      const newStatus = column.dataset.status;
      const projectId = column.dataset.projectId;

      fetch(`/projects/${projectId}/tasks/${taskId}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name=csrf-token]").content
        },
        body: JSON.stringify({
          task: { status: newStatus }
        })
      });
    });
  });
});

#app/views/projects
#create three files mannually index.html.erb, show.html.erb, new.html.erb

#app/view/projects/index.html.erb

<h1>All Projects</h1>

<%= link_to "New Project", new_project_path %>

<ul>
  <% @projects.each do |project| %>
    <li>
      <%= link_to project.name, project_path(project) %>
      <%= button_to "Delete", project_path(project), method: :delete %>
    </li>
  <% end %>
</ul>

#app/views/projects/show.html.erb

<%= link_to "← Back to Projects", projects_path %>
<%= link_to "New Project", new_project_path %>
<h1><%= @project.name %></h1>

<div style="display:flex; gap:20px;">
  <% ["todo","ongoing","completed"].each do |status| %>
    
    <div style="width:30%; border:1px solid black; padding:10px;">
      <h3><%= status.capitalize %></h3>

      <!-- COLUMN -->
      <div class="column" 
           data-status="<%= status %>" 
           data-project-id="<%= @project.id %>" 
           style="min-height:200px;">

        <% @tasks.where(status: status).each do |task| %>
          
          <!-- TASK -->
          <div class="task" 
               draggable="true" 
               data-id="<%= task.id %>" 
               style="border:1px solid gray; padding:5px; margin:5px; cursor:grab;">

            <p><%= task.name %> (<%= task.priority %>)</p>

            <%= button_to "Delete", project_task_path(@project, task), method: :delete %>
          </div>

        <% end %>
      </div>
    </div>

  <% end %>
</div>

<h3>Add Task</h3>

<%= form_with model: [@project, Task.new] do |f| %>
  <%= f.text_field :name, placeholder: "Task name" %>
  <%= f.select :status, ["todo","ongoing","completed"] %>
  <%= f.select :priority, ["low","medium","high"] %>
  <%= f.submit "Create Task" %>
<% end %>

#app/views/projects/new.html.erb

<h1>New Project</h1>

<%= form_with model: @project do |f| %>
  <div>
    <%= f.label :name %><br>
    <%= f.text_field :name %>
  </div>

  <div>
    <%= f.label :description %><br>
    <%= f.text_area :description %>
  </div>

  <%= f.submit "Create Project" %>
<% end %>



