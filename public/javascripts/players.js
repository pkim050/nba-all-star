function myFunction() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");

  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    } 
  }
}

function changeFunc() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("selectBox");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");

  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[1];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    } 
  }
}

var counter = 0;
var count = 0;

function toggleClass(e, className) {
  var firstInput = e.getElementsByTagName('td')[0];
  if (e.className.indexOf(className) >= 0) {
    e.className = e.className.replace(className, "");
    firstInput.checked = firstInput.checked;
    count = 0;
    counter -= 1;
  }
  else if (counter > 12) {
    alert("You can only pick up to 13 players for your team!");
    count = 1;
  }
  else {
    e.className += className;
    firstInput.checked = !firstInput.checked;
    counter += 1;
  }
}

(function () {
  function rowClick(e) {
      if (count > 0) {
        return;
      }
      if (e.target.nodeName === "INPUT") return;
      var checkbox = this.querySelector("input[type='checkbox']");
      if (checkbox) {
          checkbox.checked = !checkbox.checked;
      }
  }
  [].forEach.call(document.querySelectorAll("tr"), function (tr) {
      tr.addEventListener("click", rowClick);
  });
})();

function submitFunction()
{
  if (counter > 12) {
    return true;
  }
  else {
    alert("You must select 13 players.");
    return false;
  }
}