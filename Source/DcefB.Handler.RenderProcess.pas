(*
  *                  Delphi Multi-tab Chromium Browser Frame
  *
  * Usage allowed under the restrictions of the Lesser GNU General Public License
  * or alternatively the restrictions of the Mozilla Public License 1.1
  *
  * Software distributed under the License is distributed on an "AS IS" basis,
  * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
  * the specific language governing rights and limitations under the License.
  *
  * Unit owner : BccSafe <bccsafe5988@gmail.com>
  * QQ         : 1262807955
  * Web site   : http://www.bccsafe.com
  * Repository : https://github.com/bccsafe/DcefBrowser
  *
  * The code of DcefBrowser is based on DCEF3 by: Henri Gourvest <hgourvest@gmail.com>
  * code: https://github.com/hgourvest/dcef3
  *
  * Embarcadero Technologies, Inc is not permitted to use or redistribute
  * this source code without explicit permission.
  *
*)

unit DcefB.Handler.RenderProcess;

interface

uses
  Classes, SysUtils, Rtti, TypInfo, Variants,
  DcefB.Cef3.Interfaces, DcefB.Cef3.Classes, DcefB.Cef3.Types, DcefB.Cef3.Api,
  DcefB.BaseObject, DcefB.Events, DcefB.res;

type
  TDcefBRenderProcessHandler = class(TCefRenderProcessHandlerOwn,
    IDcefBRenderProcessHandler)
  private
    FOnContextReleased: TOnContextReleased;
    FOnRenderThreadCreated: TOnRenderThreadCreated;
    FOnFocusedNodeChanged: TOnFocusedNodeChanged;
    FOnBrowserCreated: TOnBrowserCreated;
    FOnUncaughtException: TOnUncaughtException;
    FOnBeforeNavigation: TOnBeforeNavigation;
    FOnWebKitInitialized: TOnWebKitInitialized;
    FOnBrowserDestroyed: TOnBrowserDestroyed;
    FOnProcessMessageReceived: TOnProcessMessageReceived;
    FOnContextCreated: TOnContextCreated;
    function GetOnBeforeNavigation: TOnBeforeNavigation;
    function GetOnBrowserCreated: TOnBrowserCreated;
    function GetOnBrowserDestroyed: TOnBrowserDestroyed;
    function GetOnContextCreated: TOnContextCreated;
    function GetOnContextReleased: TOnContextReleased;
    function GetOnFocusedNodeChanged: TOnFocusedNodeChanged;
    function GetOnProcessMessageReceived: TOnProcessMessageReceived;
    function GetOnRenderThreadCreated: TOnRenderThreadCreated;
    function GetOnUncaughtException: TOnUncaughtException;
    function GetOnWebKitInitialized: TOnWebKitInitialized;
    procedure SetOnBeforeNavigation(const Value: TOnBeforeNavigation);
    procedure SetOnBrowserCreated(const Value: TOnBrowserCreated);
    procedure SetOnBrowserDestroyed(const Value: TOnBrowserDestroyed);
    procedure SetOnContextCreated(const Value: TOnContextCreated);
    procedure SetOnContextReleased(const Value: TOnContextReleased);
    procedure SetOnFocusedNodeChanged(const Value: TOnFocusedNodeChanged);
    procedure SetOnProcessMessageReceived(const Value
      : TOnProcessMessageReceived);
    procedure SetOnRenderThreadCreated(const Value: TOnRenderThreadCreated);
    procedure SetOnUncaughtException(const Value: TOnUncaughtException);
    procedure SetOnWebKitInitialized(const Value: TOnWebKitInitialized);
  protected
    procedure OnRenderThreadCreated(const extraInfo: ICefListValue); override;
    procedure OnWebKitInitialized; override;
    procedure OnBrowserCreated(const browser: ICefBrowser); override;
    procedure OnBrowserDestroyed(const browser: ICefBrowser); override;
    function GetLoadHandler: PCefLoadHandler; override;
    function OnBeforeNavigation(const browser: ICefBrowser;
      const frame: ICefFrame; const request: ICefRequest;
      navigationType: TCefNavigationType; isRedirect: Boolean)
      : Boolean; override;
    procedure OnContextCreated(const browser: ICefBrowser;
      const frame: ICefFrame; const context: ICefv8Context); override;
    procedure OnContextReleased(const browser: ICefBrowser;
      const frame: ICefFrame; const context: ICefv8Context); override;
    procedure OnUncaughtException(const browser: ICefBrowser;
      const frame: ICefFrame; const context: ICefv8Context;
      const exception: ICefV8Exception;
      const stackTrace: ICefV8StackTrace); override;
    procedure OnFocusedNodeChanged(const browser: ICefBrowser;
      const frame: ICefFrame; const node: ICefDomNode); override;
    function OnProcessMessageReceived(const browser: ICefBrowser;
      sourceProcess: TCefProcessId; const message: ICefProcessMessage)
      : Boolean; override;
  public
    class var RegParList: Array of TRegExtentionPar;
  end;

implementation

uses
  DcefB.Core.App;

{ TDcefBRenderProcessHandler }

procedure TDcefBRenderProcessHandler.SetOnBeforeNavigation
  (const Value: TOnBeforeNavigation);
begin
  FOnBeforeNavigation := Value;
end;

procedure TDcefBRenderProcessHandler.SetOnBrowserCreated
  (const Value: TOnBrowserCreated);
begin
  FOnBrowserCreated := Value;
end;

procedure TDcefBRenderProcessHandler.SetOnBrowserDestroyed
  (const Value: TOnBrowserDestroyed);
begin
  FOnBrowserDestroyed := Value;
end;

procedure TDcefBRenderProcessHandler.SetOnContextCreated
  (const Value: TOnContextCreated);
begin
  FOnContextCreated := Value;
end;

procedure TDcefBRenderProcessHandler.SetOnContextReleased
  (const Value: TOnContextReleased);
begin
  FOnContextReleased := Value;
end;

procedure TDcefBRenderProcessHandler.SetOnFocusedNodeChanged
  (const Value: TOnFocusedNodeChanged);
begin
  FOnFocusedNodeChanged := Value;
end;

procedure TDcefBRenderProcessHandler.SetOnProcessMessageReceived
  (const Value: TOnProcessMessageReceived);
begin
  FOnProcessMessageReceived := Value;
end;

procedure TDcefBRenderProcessHandler.SetOnRenderThreadCreated
  (const Value: TOnRenderThreadCreated);
begin
  FOnRenderThreadCreated := Value;
end;

procedure TDcefBRenderProcessHandler.SetOnUncaughtException
  (const Value: TOnUncaughtException);
begin
  FOnUncaughtException := Value;
end;

procedure TDcefBRenderProcessHandler.SetOnWebKitInitialized
  (const Value: TOnWebKitInitialized);
begin
  FOnWebKitInitialized := Value;
end;

function TDcefBRenderProcessHandler.GetLoadHandler: PCefLoadHandler;
begin
  Result := nil;
end;

function TDcefBRenderProcessHandler.GetOnBeforeNavigation: TOnBeforeNavigation;
begin
  Result := FOnBeforeNavigation;
end;

function TDcefBRenderProcessHandler.GetOnBrowserCreated: TOnBrowserCreated;
begin
  Result := FOnBrowserCreated;
end;

function TDcefBRenderProcessHandler.GetOnBrowserDestroyed: TOnBrowserDestroyed;
begin
  Result := FOnBrowserDestroyed;
end;

function TDcefBRenderProcessHandler.GetOnContextCreated: TOnContextCreated;
begin
  Result := FOnContextCreated;
end;

function TDcefBRenderProcessHandler.GetOnContextReleased: TOnContextReleased;
begin
  Result := FOnContextReleased;
end;

function TDcefBRenderProcessHandler.GetOnFocusedNodeChanged
  : TOnFocusedNodeChanged;
begin
  Result := FOnFocusedNodeChanged;
end;

function TDcefBRenderProcessHandler.GetOnProcessMessageReceived
  : TOnProcessMessageReceived;
begin
  Result := FOnProcessMessageReceived;
end;

function TDcefBRenderProcessHandler.GetOnRenderThreadCreated
  : TOnRenderThreadCreated;
begin
  Result := FOnRenderThreadCreated;
end;

function TDcefBRenderProcessHandler.GetOnUncaughtException
  : TOnUncaughtException;
begin
  Result := FOnUncaughtException;
end;

function TDcefBRenderProcessHandler.GetOnWebKitInitialized
  : TOnWebKitInitialized;
begin
  Result := FOnWebKitInitialized;
end;

function TDcefBRenderProcessHandler.OnBeforeNavigation(const browser
  : ICefBrowser; const frame: ICefFrame; const request: ICefRequest;
  navigationType: TCefNavigationType; isRedirect: Boolean): Boolean;
begin
  Result := False;
end;

procedure TDcefBRenderProcessHandler.OnBrowserCreated(const browser
  : ICefBrowser);
begin
  inherited;
  if Assigned(FOnBrowserCreated) then
    FOnBrowserCreated(browser);
end;

procedure TDcefBRenderProcessHandler.OnBrowserDestroyed(const browser
  : ICefBrowser);
begin
  inherited;
  if Assigned(FOnBrowserDestroyed) then
    FOnBrowserDestroyed(browser);
end;

procedure TDcefBRenderProcessHandler.OnContextCreated(const browser
  : ICefBrowser; const frame: ICefFrame; const context: ICefv8Context);
begin
  inherited;
  if Assigned(FOnContextCreated) then
    FOnContextCreated(browser, frame, context);
end;

procedure TDcefBRenderProcessHandler.OnContextReleased(const browser
  : ICefBrowser; const frame: ICefFrame; const context: ICefv8Context);
begin
  inherited;
  if Assigned(FOnContextReleased) then
    FOnContextReleased(browser, frame, context);
end;

procedure TDcefBRenderProcessHandler.OnFocusedNodeChanged
  (const browser: ICefBrowser; const frame: ICefFrame; const node: ICefDomNode);
begin
  inherited;
  if Assigned(FOnFocusedNodeChanged) then
    FOnFocusedNodeChanged(browser, frame, node);
end;

function TDcefBRenderProcessHandler.OnProcessMessageReceived
  (const browser: ICefBrowser; sourceProcess: TCefProcessId;
  const message: ICefProcessMessage): Boolean;
  procedure DoRunInRender;
  var
    aBrowser: ICefBrowser;
    ATemp: Pointer;
    AProc: TRenderProcessCallbackA;
    aData: Pointer;
  begin
    aBrowser := ICefBrowser
      (Pointer(StrToInt64('$' + message.ArgumentList.GetString(0))));
    ATemp := Pointer(StrToInt64('$' + message.ArgumentList.GetString(1)));
    AProc := TRenderProcessCallbackA(ATemp);
    aData := Pointer(StrToInt64('$' + message.ArgumentList.GetString(2)));
    if Assigned(AProc) then
      AProc(aBrowser, browser.MainFrame.GetV8Context, aData);
    TRenderProcessCallbackA(ATemp) := nil;
  end;

begin
  if (sourceProcess = TCefProcessId.PID_BROWSER) and
    (message.Name = RUNINRENDER_MSG) then
  begin
    DoRunInRender;
    Result := True;
  end
  else if Assigned(FOnProcessMessageReceived) then
  begin
    FOnProcessMessageReceived(browser, sourceProcess, message, Result);
  end
  else
    Result := False;
end;

procedure TDcefBRenderProcessHandler.OnRenderThreadCreated(const extraInfo
  : ICefListValue);
begin
  inherited;
  if Assigned(FOnRenderThreadCreated) then
    FOnRenderThreadCreated(extraInfo);
end;

procedure TDcefBRenderProcessHandler.OnUncaughtException(const browser
  : ICefBrowser; const frame: ICefFrame; const context: ICefv8Context;
  const exception: ICefV8Exception; const stackTrace: ICefV8StackTrace);
begin
  inherited;
  if Assigned(FOnUncaughtException) then
    FOnUncaughtException(browser, frame, context, exception, stackTrace);
end;

procedure TDcefBRenderProcessHandler.OnWebKitInitialized;
var
  Index: Integer;
begin
  inherited;

  for Index := Low(RegParList) to High(RegParList) do
  begin
    if (RegParList[Index].code = '') and (RegParList[Index].Handler = nil) then
      DcefBApp.CefRegisterExtension(RegParList[Index].Name,
        RegParList[Index].Value
{$IFDEF CEF_MULTI_THREADED_MESSAGE_LOOP}, True {$ENDIF})
    else
      DcefBApp.CefRegisterExtension(RegParList[Index].Name,
        RegParList[Index].code, RegParList[Index].Handler);
  end;

  if Assigned(FOnWebKitInitialized) then
    FOnWebKitInitialized();
end;

end.
