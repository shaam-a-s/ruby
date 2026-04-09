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