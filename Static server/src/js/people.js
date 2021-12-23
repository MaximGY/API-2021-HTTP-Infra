$(function() {
    $.getJSON("/api/", function(person) {
            var personDesc = person.firstName + " " + person.lastName + ", " + person.age
            $("#person").text(personDesc)
    })
})