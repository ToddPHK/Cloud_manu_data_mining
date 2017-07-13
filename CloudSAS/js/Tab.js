
function createExampleTab(id, url){
    var win, tab, hostName, node;
    node = exampleTree.getNodeById(id);
    hostName = window.location.protocol + "//" + window.location.host;
    //debugger;
    if (node.id == "pwdMgr") {
        ChangePwdWin.show();
        return;
    }
    if (node.id == "sysExit") {
        BtnSafeExit.fireEvent("click");
        return;
    }
    //alert(node.attributes.iconCls);
    tab = CenterPanel.add(new Ext.Panel({
        id: id,
        title: node.text,
        iconCls: node.attributes.iconCls,
        layout: 'fit',
        autoLoad: {
            showMask: true,
            scripts: false,
            mode: "iframe",
            url: hostName+url
        },
        listeners: {
            deactivate: {
                fn: function(el) {
                    if (this.sWin && this.sWin.isVisible()) {
                        this.sWin.hide();
                    }
                }
            }
        },
        closable: true
    }));
    CenterPanel.setActiveTab(tab);
}