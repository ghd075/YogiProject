window.addEventListener('DOMContentLoaded', event => {
    const questiondatables = document.getElementById('questiondatables');
    if (questiondatables) {
        new simpleDatatables.DataTable(questiondatables);
    }
});