$(document).ready(function() {
  $(".faq-question").click(function() {
    const answer = $(this).next(".faq-answer");

    // Close any other open answers
    $(".faq-answer").not(answer).slideUp();

    // Toggle the clicked answer
    answer.slideToggle();
  });
});