
Ext.ns("App");

App.SexCombo = Ext.extend(Ext.form.ComboBox, {
    name: 'sex.name',
    hiddenName: 'sex',
    readOnly: true,
    fieldLabel: '�Ա�',
    valueField: 'id',
    displayField: 'name',
    typeAhead: true,
    mode: 'remote',
    triggerAction: 'all',
    emptyText: '��ѡ��',
    selectOnFocus: true,
    allowBlank: false,
    store: new Ext.data.Store({
        proxy: new Ext.data.MemoryProxy([
            [0,'δ֪'],
            [1,'��'],
            [2,'Ů']
        ]),
        reader: new Ext.data.ArrayReader({
        },['id','name'])
    })
});
Ext.reg('sexcombo', App.SexCombo);

App.sexMap = [
    'δ֪', '��', 'Ů'
];

App.SexRenderer = function(value) {
    return App.sexMap[value];
};

App.SexColumn = {
    name: 'sex',
    fieldLabel: '�Ա�',
    allowBlank: false,
    xtype: 'sexcombo',
    renderer: App.SexRenderer,
    editor: new App.SexCombo
};
