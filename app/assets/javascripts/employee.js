$(document).ready(function() {
  $('#addEmployeesButton').click(function() {
    $('#addEmployeesModal').modal('show');
  });

  $('#closeEmployeeModalButton').click(function() {
    $('#addEmployeesModal').modal('hide');
  });

  $('#saveEmployeeButton').click(function() {
    var firstName = $('#firstName').val();
    var lastName = $('#lastName').val();
    var departmentId = $('#departmentId').val();
    var designationId = $('#designationId').val();
    var emailAddress = $('#emailAddress').val();
    var csrfToken = $('meta[name="csrf-token"]').attr('content');

    $.ajax({
      url: '/employees',
      method: 'POST',
      headers: {
        'X-CSRF-Token': csrfToken
      },
      data: { employee: { first_name: firstName, last_name: lastName, department_id: departmentId, designation_id: designationId, email: emailAddress} },
      success: function(response) {
        console.log(response);
        $('#addEmployeesModal').modal('hide');
        location.reload();
      },
      error: function(xhr) {
        console.error(xhr.responseText);
      }
    });
  });
});