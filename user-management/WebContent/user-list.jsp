<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Management</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />
    <style>
      .dropdown-menu[data-bs-popper] {
        top: 155%;
        left: -125px;
      }

      .bg-gray {
        background-color: #f8f9fa;
      }
    </style>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
      <div class="container-fluid">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/list"
          >CMS</a
        >

        <div class="dropdown">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            role="button"
            data-bs-toggle="dropdown"
            aria-expanded="false"
          >
            <i class="bi bi-person-fill"></i>
          </a>
          <ul class="dropdown-menu">
            <li>
              <a class="dropdown-item" href="#"
                ><i class="bi bi-person-lines-fill me-2"></i>User Profile</a
              >
            </li>
            <li><hr class="dropdown-divider" /></li>
            <li>
              <div class="dropdown-item">
                <div class="form-check form-switch">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    role="switch"
                    id="darkModeSwitch"
                    checked
                  />
                  <label class="form-check-label" for="darkModeSwitch"
                    >Dark mode</label
                  >
                </div>
              </div>
            </li>
            <li><hr class="dropdown-divider" /></li>
            <li>
              <a class="dropdown-item" href="#"
                ><i class="bi bi-box-arrow-right me-2"></i>Logout</a
              >
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-2">
          <div class="input-group mb-3 pt-3">
            <input
              type="text"
              class="form-control"
              placeholder="Search..."
              aria-describedby="basic-addon2"
            />
            <span
              class="input-group-text"
              id="basic-addon2"
              style="cursor: pointer"
              ><i class="bi bi-search"></i
            ></span>
          </div>
          <div class="border-bottom border-top py-3">
            <a href="#" class="text-decoration-none"
              ><i class="bi bi-grid-3x3 me-3"></i>View contents</a
            >
          </div>
          <div class="border-bottom py-3">
            <a href="#" class="text-decoration-none"
              ><i class="bi bi-pencil-square me-3"></i>Form content</a
            >
          </div>
        </div>
        <div class="col-sm-10">
          <div class="p-3">
            <h2 class="border-bottom pb-3 mb-4">List of Users</h2>

            <div class="card">
              <div class="card-header">
                <a
                  href="<%=request.getContextPath()%>/new"
                  class="btn btn-success"
                  >Add new user
                </a>
              </div>
              <div class="card-body">
                <table class="table table-hover">
                  <thead>
                    <tr>
                      <th scope="col">ID</th>
                      <th scope="col">Name</th>
                      <th scope="col">Email</th>
                      <th scope="col">Phone</th>
                      <th scope="col">Actions</th>
                    </tr>
                  </thead>
                  <tbody class="table-group-divider">
                    <c:forEach var="user" items="${listUser}">
                      <tr>
                        <th scope="row"><c:out value="${user.id}" /></th>
                        <td><c:out value="${user.name}" /></td>
                        <td><c:out value="${user.email}" /></td>
                        <td><c:out value="${user.phone}" /></td>
                        <td>
                          <div class="btn-group" role="group">
                            <a
                              href="edit?id=<c:out value='${user.id}' />"
                              class="btn btn-info"
                            >
                              Edit
                            </a>
                            <!-- Button trigger modal -->
                            <button
                              type="button"
                              class="btn btn-danger"
                              data-bs-toggle="modal"
                              data-bs-target="#confirmDeleteModal"
                              data-id="<c:out value='${user.id}' />"
                              id="deleteButton-<c:out value='${user.id}' />"
                            >
                              Delete
                            </button>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>

                <!-- Modal -->
                <div
                  class="modal fade"
                  id="confirmDeleteModal"
                  tabindex="-1"
                  aria-hidden="true"
                >
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                          Message
                        </h1>
                        <button
                          type="button"
                          class="btn-close"
                          data-bs-dismiss="modal"
                          aria-label="Close"
                        ></button>
                      </div>
                      <div class="modal-body">
                        Are you sure you want to delete this user?
                      </div>
                      <div class="modal-footer">
                        <button
                          type="button"
                          class="btn btn-secondary"
                          data-bs-dismiss="modal"
                        >
                          Close
                        </button>
                        <a
                          href=""
                          class="btn btn-danger"
                          id="confirmDeleteButton"
                          >Delete</a
                        >
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
      integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
      integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
      crossorigin="anonymous"
    ></script>

    <script>
      document.addEventListener("DOMContentLoaded", (event) => {
        const htmlElement = document.documentElement;
        const switchElement = document.getElementById("darkModeSwitch");

        // Set the default theme to dark if no setting is found in local storage
        const currentTheme = localStorage.getItem("bsTheme") || "dark";
        htmlElement.setAttribute("data-bs-theme", currentTheme);
        switchElement.checked = currentTheme === "dark";

        switchElement.addEventListener("change", function () {
          if (this.checked) {
            htmlElement.setAttribute("data-bs-theme", "dark");
            localStorage.setItem("bsTheme", "dark");
          } else {
            htmlElement.setAttribute("data-bs-theme", "light");
            localStorage.setItem("bsTheme", "light");
          }
        });
      });
    </script>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const confirmDeleteModal =
          document.getElementById("confirmDeleteModal");
        const confirmDeleteButton = document.getElementById(
          "confirmDeleteButton"
        );

        confirmDeleteModal.addEventListener("show.bs.modal", function (event) {
          const button = event.relatedTarget; // Button that triggered the modal
          const userId = button.getAttribute("data-id"); // Extract info from data-* attributes

          // Update the modal's "Delete" button href with the user ID
          confirmDeleteButton.href = "delete?id=" + userId;
        });
      });
    </script>
  </body>
</html>
