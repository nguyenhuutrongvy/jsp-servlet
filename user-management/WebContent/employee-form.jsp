<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Employee Management</title>
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
            <a
              href="<%=request.getContextPath()%>/list"
              class="text-decoration-none"
              ><i class="bi bi-grid-3x3 me-3"></i>Employee list</a
            >
          </div>
          <div class="border-bottom py-3">
            <a
              href="<%=request.getContextPath()%>/new"
              class="text-decoration-none"
              ><i class="bi bi-pencil-square me-3"></i>Add employee</a
            >
          </div>
        </div>
        <div class="col-sm-10">
          <div class="p-3">
            <h2 class="border-bottom pb-3 mb-4">
              <c:if test="${employee != null}">Edit Employee</c:if>
              <c:if test="${employee == null}">Add New Employee</c:if>
            </h2>

            <div class="card">
              <div class="card-header">Information of Employee</div>
              <div class="card-body">
                <form action=${employee != null ? "update" : "insert"} method="post">
                  <c:if test="${employee != null}">
                    <input type="hidden" name="id" value="<c:out value='${employee.id}' />" />
                  </c:if>
                  <div class="row mb-3">
                    <div class="col">
                      <label for="firstNameInput" class="form-label"
                        >First name</label
                      >
                      <input
                        type="text"
                        class="form-control"
                        id="firstNameInput"
                        value="<c:out value='${employee.firstName}' />"
                        name="firstName"
                        required
                        minlength="2"
                      />
                    </div>
                    <div class="col">
                      <label for="lastNameInput" class="form-label"
                      >Last name</label
                    >
                    <input
                      type="text"
                      class="form-control"
                      id="lastNameInput"
                      value="<c:out value='${employee.lastName}' />"
                      name="lastName"
                      required
                      minlength="2"
                    />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <div class="col">
                      <label for="genderInput" class="form-label"
                        >Gender</label
                      >
                      <select class="form-select" id="genderInput" name="gender">
                        <option value="0" ${employee != null && employee.gender == 0 ? "selected" : ""}>Male</option>
                        <option value="1" ${employee != null && employee.gender == 1 ? "selected" : ""}>Female</option>
                        <option value="2" ${employee != null && employee.gender == 2 ? "selected" : ""}>Other</option>
                      </select>
                    </div>
                    <div class="col">
                      <label for="dateOfBirthInput" class="form-label"
                      >Date of birth</label
                    >
                    <input
                      type="date"
                      class="form-control"
                      id="dateOfBirthInput"
                      value="<c:out value='${employee.dateOfBirth}' />"
                      name="dateOfBirth"
                    />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <div class="col">
                      <label for="phoneInput" class="form-label"
                        >Phone number</label
                      >
                      <input type="tel" class="form-control" id="phoneInput" value="<c:out value='${employee.phone}' />" name="phone"/>
                    </div>
                    <div class="col">
                      <label for="departmentInput" class="form-label"
                      >Department name</label
                    >
                    <input type="text" class="form-control" id="departmentInput" value="<c:out value='${employee.departmentName}' />" name="departmentName"/>
                    </div>
                  </div>
                  <div class="mb-3">
                    <label for="addressInput" class="form-label"
                      >Address</label
                    >
                    <input type="text" class="form-control" id="addressInput" value="<c:out value='${employee.address}' />" name="address"/>
                  </div>
                  <div class="mb-3">
                    <label for="remarkInput" class="form-label"
                      >Remark</label
                    >
                    <input type="text" class="form-control" id="remarkInput" value="<c:out value='${employee.remark}' />" name="remark"/>
                  </div>
                  <c:if test="${employee == null}">
                    <button type="reset" class="btn btn-warning">Reset</button>
                  </c:if>
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
