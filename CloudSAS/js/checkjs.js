	

function CheckAll(form)
  {
  for (var i=0;i<form.elements.length;i++)
    {
    var e = form.elements[i];
    if (e.name != 'chkall')
       e.checked = document.info.chkall.checked;
    }
  }
  function selclass() {
	window.open('selClass.aspx','','width=250,height=200,left=360,top=250,scrollbars=yes');
}
