$(function() {

    const TIMEOUT_MS = 1337

    // Retrieves a new JSON payload from the dynamic server
    function getPerson() {
        $.getJSON("/api/", function(person) {
                var personDesc = person.firstName + " " + person.lastName + ", " + person.age
                $("#person").text(personDesc)
        })
    }

    // Gets a first person and refreshes it every so often
    getPerson()
    setInterval(getPerson, TIMEOUT_MS)
})