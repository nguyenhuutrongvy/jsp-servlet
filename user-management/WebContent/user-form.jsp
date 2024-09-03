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
            <h2 class="border-bottom pb-3 mb-4">
              <c:if test="${user != null}">Edit User</c:if>
              <c:if test="${user == null}">Add New User</c:if>
            </h2>

            <div class="card">
              <div class="card-header">Information of User</div>
              <div class="card-body">
                <c:if test="${user != null}">
                  <form action="update" method="post">
				        </c:if>
                <c:if test="${user == null}">
                  <form action="insert" method="post">
                </c:if>
                  <c:if test="${user != null}">
                    <input type="hidden" name="id" value="<c:out value='${user.id}' />" />
                  </c:if>
                  <div class="mb-3">
                    <label for="userNameInput" class="form-label"
                      >User name</label
                    >
                    <input
                      type="text"
                      class="form-control"
                      id="userNameInput"
                      value="<c:out value='${user.name}' />"
                      name="name"
                      required
                      minlength="2"
                    />
                  </div>
                  <div class="mb-3">
                    <label for="emailInput" class="form-label"
                      >Email address</label
                    >
                    <input
                      type="email"
                      class="form-control"
                      id="emailInput"
                      aria-describedby="emailHelp"
                      value="<c:out value='${user.email}' />"
                      name="email"
                      required
                    />
                  </div>
                  <div class="mb-3">
                    <label for="phoneInput" class="form-label"
                      >Phone number</label
                    >
                    <input type="tel" class="form-control" id="phoneInput" value="<c:out value='${user.phone}' />" name="phone"/>
                  </div>
                  <button type="submit" class="btn btn-primary">Save</button>
                </form>
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
  </body>
</html>
