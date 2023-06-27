$(document).ready(function() {
  $('#addDepartmentButton').click(function() {
    $('#addDepartmentModal').modal('show');
  });

  $('#closeDepartmentModalButton').click(function() {
    $('#addDepartmentModal').modal('hide');
  });

  $(document).on('click', '.edit-bill-link', function(e) {
    e.preventDefault();
    var billId = $(this).data('bill-id');
    $('#addBillsModal').modal('show');
  });

  $('#saveDepartmentButton').click(function() {
    var departmentName = $('#departmentName').val();
    var csrfToken = $('meta[name="csrf-token"]').attr('content');

    $.ajax({
      url: '/departments',
      method: 'POST',
      headers: {
        'X-CSRF-Token': csrfToken
      },
      data: { department: { name: departmentName } },
      success: function(response) {
        console.log(response);
        $('#addDepartmentModal').modal('hide');
        location.reload();
      },
      error: function(xhr) {
        console.error(xhr.responseText);
      }
    });
  });
});