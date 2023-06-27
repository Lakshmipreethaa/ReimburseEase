$(document).ready(function() {
  $('#addDesignationButton').click(function() {
    $('#addDesignationModal').modal('show');
  });

  $('#closeDesignationModalButton').click(function() {
    $('#addDesignationModal').modal('hide');
  });

  $(document).on('click', '.edit-designation-link', function(e) {
    e.preventDefault();
    var designationId = $(this).data('designation-id');

    $('#addDesignationModal').modal('show');
  });

  $('#saveDesignationButton').click(function() {
    var designationName = $('#designationName').val();
    var csrfToken = $('meta[name="csrf-token"]').attr('content');

    $.ajax({
      url: '/designations',
      method: 'POST',
      headers: {
        'X-CSRF-Token': csrfToken
      },
      data: { designation: { name: designationName } },
      success: function(response) {
        console.log(response);
        $('#addDesignationModal').modal('hide');
        location.reload();
      },
      error: function(xhr) {
        console.error(xhr.responseText);
      }
    });
  });
});