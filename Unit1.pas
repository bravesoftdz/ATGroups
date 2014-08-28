{$ifdef FPC}
  {$mode delphi}
{$else}
  {$define SP}
{$endif}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ATGroups, StdCtrls, ExtCtrls, ATTabs, Menus,
  {$ifdef SP}
  SpTbxSkins,
  {$endif}
  ComCtrls;

type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    mnuClose: TMenuItem;
    MainMenu1: TMainMenu;
    Mode1: TMenuItem;
    N11: TMenuItem;
    N2horz1: TMenuItem;
    N2vert1: TMenuItem;
    N3horz1: TMenuItem;
    N3vert1: TMenuItem;
    N4horz1: TMenuItem;
    N4vert1: TMenuItem;
    N4grid1: TMenuItem;
    N1: TMenuItem;
    m1: TMenuItem;
    m2: TMenuItem;
    m3: TMenuItem;
    m4: TMenuItem;
    Tree: TTreeView;
    Focus1: TMenuItem;
    Next1: TMenuItem;
    N12: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N2: TMenuItem;
    Pr1: TMenuItem;
    mNext: TMenuItem;
    mPre: TMenuItem;
    N3: TMenuItem;
    Movetab1: TMenuItem;
    tonext1: TMenuItem;
    toprev1: TMenuItem;
    N6grid1: TMenuItem;
    group51: TMenuItem;
    group61: TMenuItem;
    togroup51: TMenuItem;
    togroup61: TMenuItem;
    N4: TMenuItem;
    toothergroup1: TMenuItem;
    N121: TMenuItem;
    mnuCloseThis: TMenuItem;
    mnuCloseOthSame: TMenuItem;
    mnuCloseOthAll: TMenuItem;
    mnuCloseAll: TMenuItem;
    mnuCloseAllThis: TMenuItem;
    mTree: TMenuItem;
    Status: TStatusBar;
    mnuCloseRt: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    mnuCloseLt: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N2horz1Click(Sender: TObject);
    procedure N2vert1Click(Sender: TObject);
    procedure N3horz1Click(Sender: TObject);
    procedure N3vert1Click(Sender: TObject);
    procedure N4horz1Click(Sender: TObject);
    procedure N4vert1Click(Sender: TObject);
    procedure N4grid1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure m1Click(Sender: TObject);
    procedure m2Click(Sender: TObject);
    procedure m3Click(Sender: TObject);
    procedure m4Click(Sender: TObject);
    procedure TreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Next1Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure Pr1Click(Sender: TObject);
    procedure mNextClick(Sender: TObject);
    procedure mPreClick(Sender: TObject);
    procedure tonext1Click(Sender: TObject);
    procedure toprev1Click(Sender: TObject);
    procedure TreeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure N6grid1Click(Sender: TObject);
    procedure group51Click(Sender: TObject);
    procedure group61Click(Sender: TObject);
    procedure togroup51Click(Sender: TObject);
    procedure togroup61Click(Sender: TObject);
    procedure toothergroup1Click(Sender: TObject);
    procedure N121Click(Sender: TObject);
    procedure mnuCloseThisClick(Sender: TObject);
    procedure mnuCloseAllClick(Sender: TObject);
    procedure mnuCloseOthSameClick(Sender: TObject);
    procedure mnuCloseOthAllClick(Sender: TObject);
    procedure mnuCloseAllThisClick(Sender: TObject);
    procedure mTreeClick(Sender: TObject);
    procedure mnuCloseRtClick(Sender: TObject);
    procedure mnuCloseLtClick(Sender: TObject);
  private
    { Private declarations }
    procedure TabClose(Sender: TObject; ATabIndex: Integer;
      var ACanClose, ACanContinue: boolean);
    procedure TabAdd(Sender: TObject);
    procedure AddTab(Pages: TATPages);
    procedure TabPopup(S: TObject);
    procedure TabFocus(S: TObject);
    procedure TabOver(S: TObject; N: Integer);
    procedure MoveTabTo(Num: Integer);
    procedure MemoFocus(S: TObject);
  public
    { Public declarations }
    Groups: TATGroups;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AddTab(Pages: TATPages);
var
  F: TMemo;
  i: Integer;
  ch: Char;
begin
  F:= TMemo.Create(Self);
  F.Visible:= false;
  F.Parent:= Self;
  F.ScrollBars:= ssBoth;
  F.BorderStyle:= bsNone;
  F.OnEnter:= MemoFocus;

  ch:= Chr(Ord('A')+Random(26));
  for i:= 0 to 1+Random(4) do
    F.Lines.Add(StringOfChar(ch, 2+Random(50)));
  Pages.AddTab(F, 'tab'+ch);
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  Tree.FullExpand;
  {$ifdef SP}
  SkinManager.SetSkin('Aluminum');
  {$endif}

  Groups:= TATGroups.Create(Self);
  Groups.Parent:= Self;
  Groups.Align:= alClient;
  Groups.OnTabPopup:= TabPopup;
  Groups.OnTabFocus:= TabFocus;
  Groups.OnTabClose:= TabClose;
  Groups.OnTabAdd:= TabAdd;
  Groups.OnTabOver:= TabOver;

  Groups.SetTabOption(tabColorFont, clBlack);
  Groups.SetTabOption(tabColorActive, clBtnFace);
  Groups.SetTabOption(tabColorPassive, clLtGray);
  Groups.SetTabOption(tabColorPassiveOver, clMedGray);
  Groups.SetTabOption(tabColorBorderActive, clMedGray);
  Groups.SetTabOption(tabColorBorderPassive, clMedGray);

  AddTab(Groups.Pages1);
  AddTab(Groups.Pages1);
  AddTab(Groups.Pages1);
  AddTab(Groups.Pages2);
  AddTab(Groups.Pages2);
end;

procedure TForm1.TabAdd(Sender: TObject);
begin
  AddTab((Sender as TATTabs).Parent as TATPages);
end;

procedure TForm1.TabClose(Sender: TObject; ATabIndex: Integer;
  var ACanClose, ACanContinue: boolean);
var
  D: TATTabData;
  Id, Res: Integer;
begin
  D:= (Sender as TATTabs).GetTabData(ATabIndex);

  if ACanContinue then Id:= mb_yesnocancel else Id:= mb_okcancel;
  Res:= Application.MessageBox(PChar(string('Close: '+D.TabCaption)), 'Close', Id);
  
  ACanClose:= (Res=idok) or (Res=idyes);
  ACanContinue:= Res<>idcancel;

  if ACanClose then
    D.TabObject.Free;
end;

procedure TForm1.TabPopup(S: TObject);
var
  D: TATTabData;
  P: TPoint;
begin
  D:= Groups.PopupPages.Tabs.GetTabData(Groups.PopupTabIndex);
  if D=nil then Exit;
  mnuCloseThis.Caption:= 'this tab: '+D.TabCaption;

  P:= Mouse.CursorPos;
  PopupMenu1.Popup(P.X, P.Y);
end;

procedure TForm1.N11Click(Sender: TObject);
begin
  Groups.Mode:= gmOne;
end;

procedure TForm1.N2horz1Click(Sender: TObject);
begin
  Groups.Mode:= gm2Horz;
end;

procedure TForm1.N2vert1Click(Sender: TObject);
begin
  Groups.Mode:= gm2Vert;
end;

procedure TForm1.N3horz1Click(Sender: TObject);
begin
  Groups.Mode:= gm3Horz;
end;

procedure TForm1.N3vert1Click(Sender: TObject);
begin
  Groups.Mode:= gm3Vert;
end;

procedure TForm1.N121Click(Sender: TObject);
begin
  Groups.Mode:= gm3Plus;
end;

procedure TForm1.N4horz1Click(Sender: TObject);
begin
  Groups.Mode:= gm4Horz;
end;

procedure TForm1.N4vert1Click(Sender: TObject);
begin
  Groups.Mode:= gm4Vert;
end;

procedure TForm1.N4grid1Click(Sender: TObject);
begin
  Groups.Mode:= gm4Grid;
end;

procedure TForm1.N6grid1Click(Sender: TObject);
begin
  Groups.Mode:= gm6Grid;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Groups.Mode:= gm2Horz;
end;

procedure TForm1.MoveTabTo(Num: Integer);
begin
  Groups.MoveTab(Groups.PopupPages, Groups.PopupTabIndex, Groups.Pages[Num], -1, false);
end;

procedure TForm1.m1Click(Sender: TObject);
begin
  MoveTabTo(1);
end;

procedure TForm1.m2Click(Sender: TObject);
begin
  MoveTabTo(2);
end;

procedure TForm1.m3Click(Sender: TObject);
begin
  MoveTabTo(3);
end;

procedure TForm1.m4Click(Sender: TObject);
begin
  MoveTabTo(4);
end;

procedure TForm1.togroup51Click(Sender: TObject);
begin
  MoveTabTo(5);
end;

procedure TForm1.togroup61Click(Sender: TObject);
begin
  MoveTabTo(6);
end;

procedure TForm1.TreeDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  N: TTreeNode;
  S: string;
begin
  if Source is TMemo then
    S:= 'text: '+(Source as TMemo).Lines[0];

  N:= Tree.GetNodeAt(X, Y);
  if N=nil then begin Beep; Exit end;
  Tree.Items.AddChild(N, S);
  Tree.FullExpand;
end;

procedure TForm1.Next1Click(Sender: TObject);
begin
  Groups.PagesSetNext(true);
end;

procedure TForm1.Pr1Click(Sender: TObject);
begin
  Groups.PagesSetNext(false);
end;

procedure TForm1.N12Click(Sender: TObject);
begin
  if not Groups.PagesSetIndex(1) then beep;
end;

procedure TForm1.N21Click(Sender: TObject);
begin
  if not Groups.PagesSetIndex(2) then beep;
end;

procedure TForm1.N31Click(Sender: TObject);
begin
  if not Groups.PagesSetIndex(3) then beep;
end;

procedure TForm1.N41Click(Sender: TObject);
begin
  if not Groups.PagesSetIndex(4) then beep;
end;

procedure TForm1.group51Click(Sender: TObject);
begin
  if not Groups.PagesSetIndex(5) then beep;
end;

procedure TForm1.group61Click(Sender: TObject);
begin
  if not Groups.PagesSetIndex(6) then beep;
end;

procedure TForm1.mNextClick(Sender: TObject);
begin
  Groups.MovePopupTabToNext(true);
end;

procedure TForm1.mPreClick(Sender: TObject);
begin
  Groups.MovePopupTabToNext(false);
end;

procedure TForm1.TabFocus(S: TObject);
var
  D: TATTabData;
begin
  D:= (S as TATTabs).GetTabData((S as TATTabs).TabIndex);
  if D<>nil then
  begin
    (D.TabObject as TMemo).SetFocus;
  end;
end;

procedure TForm1.MemoFocus(S: TObject);
begin
  Groups.PagesCurrent:= (S as TMemo).Parent as TATPages;
  Caption:= Format('Group: %d', [Groups.PagesIndexOf(Groups.PagesCurrent)]);
end;

procedure TForm1.tonext1Click(Sender: TObject);
begin
  Groups.MoveCurrentTabToNext(true);
end;

procedure TForm1.toprev1Click(Sender: TObject);
begin
  Groups.MoveCurrentTabToNext(false);
end;

procedure TForm1.TreeDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept:= true;
end;

procedure TForm1.toothergroup1Click(Sender: TObject);
begin
  Groups.MoveCurrentTabToOpposite;
end;

procedure TForm1.mnuCloseThisClick(Sender: TObject);
begin
  Groups.PopupPages.Tabs.DeleteTab(Groups.PopupTabIndex, true, true);
end;

procedure TForm1.mnuCloseOthSameClick(Sender: TObject);
begin
  Groups.CloseTabs(tabCloseOthersThisPage, true);
end;

procedure TForm1.mnuCloseOthAllClick(Sender: TObject);
begin
  Groups.CloseTabs(tabCloseOthersAllPages, true);
end;

procedure TForm1.mnuCloseAllClick(Sender: TObject);
begin
  Groups.CloseTabs(tabCloseAll, false);
end;

procedure TForm1.mnuCloseAllThisClick(Sender: TObject);
begin
  Groups.CloseTabs(tabCloseAllThisPage, true);
end;

procedure TForm1.mTreeClick(Sender: TObject);
begin
  with Tree do Visible:= not Visible;
end;

procedure TForm1.TabOver(S: TObject; N: Integer);
begin
  if N>=0 then
    Status.SimpleText:= 'Mouse over tab '+IntToStr(N)
  else
    Status.SimpleText:= '';  
end;

procedure TForm1.mnuCloseRtClick(Sender: TObject);
begin
  Groups.CloseTabs(tabCloseRighterThisPage, true);
end;

procedure TForm1.mnuCloseLtClick(Sender: TObject);
begin
  Groups.CloseTabs(tabCloseLefterThisPage, true);
end;

end.
