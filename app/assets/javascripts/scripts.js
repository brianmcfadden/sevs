  function loadListOptions(listName) {
    if (typeof(Storage) !== "undefined") {
      var list = document.getElementById(listName);
      list.innerHTML = window.localStorage.getItem(listName);
    }
  }
  function list_options_change(listName) {
    if (typeof(Storage) !== "undefined") {
      var list = document.getElementById(listName);
      window.localStorage.setItem(listName, list.innerHTML);
    }
  }

  function list_add_from_to(fromListName, toListName) {
    var fromList = document.getElementById(fromListName);
    var fromListItem = fromList.options[fromList.selectedIndex];
    var option = document.createElement("option");
    option.id = fromListItem.value; // setting ID so we can use namedItem
    option.value = fromListItem.value;
    option.text = fromListItem.text;
    var list = document.getElementById(toListName);
    if (list.namedItem(option.value) == null) {
      list.add(option);
    }
    list_options_change(toListName);
    list.scrollTop = list.scrollHeight;
  }
  function list_remove_selected(listName) {
    var list = document.getElementById(listName);
    list.remove(list.selectedIndex);
    list_options_change(listName);
  }
  function list_remove_all(listName) {
    var list = document.getElementById(listName);
    list.innerHTML = '';
    list_options_change(listName);
  }
  function list_select_all(listName) {
    var list = document.getElementById(listName);
    for(var i=0; i<list.options.length; i++) {
      list.options[i].selected = true;
    }
  }
  function onEnter(event, fromList, toList) {
    return event.charCode !== 13 ||
      list_add_from_to(fromList, toList);
  }
  function formsubmit() {
    list_select_all("drugList");
    list_select_all("symptomList");
  }

////////////////////////////////////////////////////////////////

const inType = {
  DRUG: 1,
  SYMPTOM: 2
}

var drug_xhr = new XMLHttpRequest();
drug_xhr.onreadystatechange = function() { doReadyStateChange(inType.DRUG); }
var symptom_xhr = new XMLHttpRequest();
symptom_xhr.onreadystatechange = function() { doReadyStateChange(inType.SYMPTOM); }

function doOptionClicked(itemid, itemname, type) {
  switch(type) {
    case inType.DRUG:
      listName = "drugList";
      dropDownName = "drug_data";
      textName = "drug_text";
      break;
    case inType.SYMPTOM:
      listName = "symptomList";
      dropDownName = "symptom_data";
      textName = "symptom_text";
      break;
    default:
      return false;
  }
  listElement = document.getElementById(listName);
  dropDownElement = document.getElementById(dropDownName);
  option = document.createElement("option");
  option.id = itemid;
  option.value = itemid;
  option.text = itemname;
  if (listElement.namedItem(option.value) == null) {
    listElement.add(option);
  }
  list_options_change(listName);
  listElement.scrollTop = listElement.scrollHeight;
  dropDownElement.style.display = "none";
  document.getElementById(textName).value = "";
}

function doReadyStateChange(type) {
  switch(type) {
    case inType.DRUG:
      xhr = drug_xhr;
      dataElement = "drug_data";
      break;
    case inType.SYMPTOM:
      xhr = symptom_xhr;
      dataElement = "symptom_data";
      break;
    default:
      return;
  }
  if (xhr.readyState === 4 && xhr.status === 200) {
    var data = document.getElementById(dataElement);
    var response = JSON.parse( xhr.response );
    data.innerHTML = "";
    response.forEach(function(item) {
      var option = document.createElement('a');
      option.style = "text-decoration: none; font-family: verdana, arial, helvetica, sans-serif; font-size: 13px";
      option.style.padding = '8px 0px';
      option.style.border = '1px solid';
      option.style.display = 'block';
      option.value = item.name;
      option.id = item.id;
      option.innerHTML = item.name;
      option.href = "javascript:doOptionClicked("+item.id+",\""+item.name+"\","+type+");";
      data.appendChild(option);
    });
  }
}

function doOnKey(event, type, text, root_url) {
  switch(type) {
    case inType.DRUG:
      inElement = "drug_data";
      inUrlBase = root_url + "check/drugs/";
      xhr = drug_xhr;
      break;
    case inType.SYMPTOM:
      inElement = "symptom_data";
      inUrlBase = root_url + "check/symptoms/";
      xhr = symptom_xhr;
      break;
    default:
      return false;
  }
  var url = inUrlBase + text;
  var data = document.getElementById(inElement);
  if (text.length == 0) {
    data.style.display = "none";
  } else {
    data.style.display = "block";
    xhr.open('GET', url, true);
    xhr.send();
  }
  return false;
}
