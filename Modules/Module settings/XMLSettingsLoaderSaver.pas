unit XMLSettingsLoaderSaver;

interface

uses
  InterfaceSettingsLoaderSaver, Settings, Xml.XMLDoc, System.SysUtils, ConstXMLSettingsLoaderSaver;

type
  TXMLSettingsLoaderSaver = class (TInterfacedObject, ISettingsSaverLoader)
    public
      procedure LoadSettings (var p_Settings : TSettings);
      procedure SaveSettings (const p_Settings : TSettings);
  end;

implementation

uses
  Xml.XMLIntf;

{ TXMLSettingsLoaderSaver }

procedure TXMLSettingsLoaderSaver.LoadSettings(var p_Settings: TSettings);
var
  pomDocument : IXMLDocument;
  pomNode     : IXMLNode;
begin
  pomDocument := TXMLDocument.Create(nil);
  if FileExists (rs_FileName) then
  begin
    pomDocument.LoadFromFile (rs_FileName);
    pomNode := pomDocument.ChildNodes.FindNode (rs_NN_Settings);

    if Assigned (pomNode) then
      p_Settings.MainFolderPath := pomNode.ChildNodes.FindNode(rs_NN_MianFolderPath).Text;
  end;
end;

procedure TXMLSettingsLoaderSaver.SaveSettings(const p_Settings: TSettings);
var
  pomDocument  : IXMLDocument;
  pomNode      : IXMLNode;
begin
  pomDocument := TXMLDocument.Create(nil);
  pomDocument.Active := True;

  pomDocument.DocumentElement := pomDocument.CreateNode (rs_NN_Settings, ntElement, '');
  pomNode := pomDocument.DocumentElement.AddChild (rs_NN_MianFolderPath);
  pomNode.Text := p_Settings.MainFolderPath;

  pomDocument.SaveToFile (rs_FileName);
end;

end.
