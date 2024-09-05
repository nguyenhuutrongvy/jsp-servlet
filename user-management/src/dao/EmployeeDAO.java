package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.Employee;

public class EmployeeDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/servlet";
    private String jdbcUsername = "root";
    private String jdbcPassword = "1234";

    private static final String INSERT_EMPLOYEE_SQL = "INSERT INTO employee (first_name, last_name, gender, date_of_birth, phone, address, department_name, remark) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
    private static final String SELECT_EMPLOYEE_BY_ID_SQL = "SELECT * FROM employee WHERE employee_id = ?;";
    private static final String SELECT_ALL_EMPLOYEE_SQL = "SELECT * FROM employee;";
    private static final String UPDATE_EMPLOYEE_SQL = "UPDATE employee SET first_name = ?, last_name = ?, gender = ?, date_of_birth = ?, phone = ?, address = ?, department_name = ?, remark = ? WHERE employee_id = ?;";
    private static final String DELETE_USERS_SQL = "DELETE FROM employee WHERE employee_id = ?;";

    public EmployeeDAO() {
    }

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertEmployee(Employee employee) throws SQLException {
        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_EMPLOYEE_SQL)) {

            preparedStatement.setString(1, employee.getFirstName());
            preparedStatement.setString(2, employee.getLastName());
            preparedStatement.setInt(3, employee.getGender());
            preparedStatement.setDate(4, java.sql.Date.valueOf(employee.getDateOfBirth()));
            preparedStatement.setString(5, employee.getPhone());
            preparedStatement.setString(6, employee.getAddress());
            preparedStatement.setString(7, employee.getDepartmentName());
            preparedStatement.setString(8, employee.getRemark());

            System.out.println(preparedStatement);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public Employee selectEmployee(int id) {
        Employee employee = null;

        // Step 1: Establishing a Connection
        try (Connection connection = getConnection();
                // Step 2: Create a statement using connection object
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EMPLOYEE_BY_ID_SQL);) {

            preparedStatement.setInt(1, id);

            System.out.println(preparedStatement);

            // Step 3: Execute the query or update query
            ResultSet rs = preparedStatement.executeQuery();

            // Step 4: Process the ResultSet object.
            while (rs.next()) {
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                int gender = rs.getInt("gender");
                LocalDate dateOfBirth = rs.getDate("date_of_birth").toLocalDate();
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String departmentName = rs.getString("department_name");
                String remark = rs.getString("remark");
                employee = new Employee(id, firstName, lastName, gender, dateOfBirth, phone, address, departmentName,
                        remark);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return employee;
    }

    public List<Employee> selectAllEmployees() {
        List<Employee> employees = new ArrayList<>();

        // Step 1: Establishing a Connection
        try (Connection connection = getConnection();
                // Step 2: Create a statement using connection object
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_EMPLOYEE_SQL);) {

            System.out.println(preparedStatement);

            // Step 3: Execute the query or update query
            ResultSet rs = preparedStatement.executeQuery();

            // Step 4: Process the ResultSet object.
            while (rs.next()) {
                int id = rs.getInt("employee_id");
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                int gender = rs.getInt("gender");
                LocalDate dateOfBirth = rs.getDate("date_of_birth").toLocalDate();
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String departmentName = rs.getString("department_name");
                String remark = rs.getString("remark");
                employees.add(new Employee(id, firstName, lastName, gender, dateOfBirth, phone, address, departmentName,
                        remark));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return employees;
    }

    public boolean deleteEmployee(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
                PreparedStatement statement = connection.prepareStatement(DELETE_USERS_SQL);) {

            statement.setInt(1, id);

            System.out.println(statement);

            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateEmployee(Employee employee) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
                PreparedStatement statement = connection.prepareStatement(UPDATE_EMPLOYEE_SQL);) {

            statement.setString(1, employee.getFirstName());
            statement.setString(2, employee.getLastName());
            statement.setInt(3, employee.getGender());
            statement.setDate(4, java.sql.Date.valueOf(employee.getDateOfBirth()));
            statement.setString(5, employee.getPhone());
            statement.setString(6, employee.getAddress());
            statement.setString(7, employee.getDepartmentName());
            statement.setString(8, employee.getRemark());
            statement.setInt(9, employee.getId());

            System.out.println(statement);

            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}