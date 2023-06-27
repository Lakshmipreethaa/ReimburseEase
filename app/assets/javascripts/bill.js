$(document).ready(function() {
  $('#addBillsButton').click(function() {
    $('#addBillsModal').modal('show');
  });

  $('#closeBillsModalButton').click(function() {
    $('#addBillsModal').modal('hide');
  });


  $(document).on('click', '.edit-bill-link', function(e) {
    e.preventDefault();
    var billId = $(this).data('bill-id');
    $('#addBillsModal').modal('show');
  });

  $('#saveBillButton').click(function() {
    var amount = $('#amount').val();
    var employeeId = $('#employeeId').val();
    var billType = $('#billType').val();
    var csrfToken = $('meta[name="csrf-token"]').attr('content');

    $.ajax({
      url: '/bills',
      method: 'POST',
      headers: {
        'X-CSRF-Token': csrfToken
      },
      data: { bill: { amount: amount, employee_id: employeeId, bill_type: billType } },
      success: function(response) {
        console.log(response);
        $('#addBillsModal').modal('hide');
        location.reload();
      },
      error: function(xhr) {
        console.error(xhr.responseText);
      }
    });
  });
});