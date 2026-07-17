params ["_group",["_interfaceInit",false],"_isDialog","_settings"];

private _listGroup = _group controlsGroupCtrl 10;

  
// "TF101_Private\addons\Data\data\background\bg1.jpg"
// "a3\ui_f_curator\data\cfgdiaryimages\altis\poliakko_ca.paa"

private _media = createHashMapFromArray [
	["Media", [
			["IMAGE", "TF101_Private\addons\Data\data\background\bg1.jpg"],
			["IMAGE", "a3\ui_f_curator\data\cfgdiaryimages\altis\poliakko_ca.paa"],
			// ["VIDEO", "a3\ui_f\Video\preview_dlcbundle2.ogv"], //- this turns out just .gif ,but in .ogv format :(
			["WEB_LINK", "https://www.youtube.com/watch?v=xvFZjo5PgG0&autoplay=1&loop=1"]
		]
	],
	["Index", 0]
];

//- Create DropMenu
	private _tasks = ((createHashMapFromArray [
		[
			"Destroy Radio Tower",
			[
				"Our primary objective is to disable CSAT's local communications.<br/><br/>Intel reports a reinforced radio tower situated on the hill overlooking Zaros (Grid 042-081). Neutralizing this tower will cut off enemy reinforcements.<br/><br/>Expect light-to-moderate infantry patrol presence.",
				_media
			]
		],
		[
			"Apprehend Officer",
			[
				"Intel has tracked Colonel ""Dimitrov"" to a temporary safehouse (East of Pyrgos). He is carrying vital decryption keys.<br/><br/>Try to <t color='#FFD700'>secure him alive</t>. If he is neutralized, you must search his body for the decryption drive."
			]
		]
	]) toArray false);
	reverse _tasks;
  
  [
    "ATAK_TaskView_Tag",
    _listGroup,
    _isDialog,
    _tasks
  ] call BCE_fnc_Create_ATAK_Custom_DropMenu;
