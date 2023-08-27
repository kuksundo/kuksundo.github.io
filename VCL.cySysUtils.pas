{   Unit VCL.cySysUtils

    Description:
    Unit with system functions.

    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    $  €€€ Accept any PAYPAL DONATION $$$  €
    $      to: mauricio_box@yahoo.com      €
    €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€

    * ***** BEGIN LICENSE BLOCK *****
    *
    * Version: MPL 1.1
    *
    * The contents of this file are subject to the Mozilla Public License Version
    * 1.1 (the "License"); you may not use this file except in compliance with the
    * License. You may obtain a copy of the License at http://www.mozilla.org/MPL/
    *
    * Software distributed under the License is distributed on an "AS IS" basis,
    * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
    * the specific language governing rights and limitations under the License.
    *
    * The Initial Developer of the Original Code is Mauricio
    * (https://sourceforge.net/projects/tcycomponents/).
    *
    * Donations: see Donation section on Description.txt
    *
    * Alternatively, the contents of this file may be used under the terms of
    * either the GNU General Public License Version 2 or later (the "GPL"), or the
    * GNU Lesser General Public License Version 2.1 or later (the "LGPL"), in which
    * case the provisions of the GPL or the LGPL are applicable instead of those
    * above. If you wish to allow use of your version of this file only under the
    * terms of either the GPL or the LGPL, and not to allow others to use your
    * version of this file under the terms of the MPL, indicate your decision by
    * deleting the provisions above and replace them with the notice and other
    * provisions required by the LGPL or the GPL. If you do not delete the
    * provisions above, a recipient may use your version of this file under the
    * terms of any one of the MPL, the GPL or the LGPL.
    *
    * ***** END LICENSE BLOCK *****}

unit VCL.cySysUtils;

{$I ..\Core\cyCompilerDefines.inc}

interface

uses classes, sysUtils, {$IFDEF DELPHIXE2_OR_ABOVE} System.Types, System.IOUtils, System.Zip, {$ENDIF} comCtrls, controls, {$IFDEF UNICODE} WideStrUtils, {$ENDIF} forms;

type
  TZipProgressEvent = procedure(Sender: TObject) of object;

  TMyZipFile = class(TZipFile)
    FOnProgress: TNotifyEvent;
  public
    property OnProgress: TNotifyEvent read FOnProgress write FOnProgress;
  end;

  TDelimiterMode = (delimAuto, delimOSPlatorm, delimWindows, delimMacOSLinuxFtp);

  procedure SortArrayOfIntegers(var aArray: Array of Integer);

  // File system utils:
  function IsFolder(SRec: TSearchrec): Boolean;

  function isFolderReadOnly(Directory: String): Boolean;

  function DirectoryIsEmpty(Directory: String): Boolean;

  function DirectoryWithSubDir(Directory: String): Boolean;

  procedure GetSubDirs(FromDirectory: String; aList: TStrings);

  function DiskFreeBytes(Drv: Char): Int64;

  function DiskBytes(Drv: Char): Int64;

  function GetFileBytes(Filename: String): Int64;

  function GetFilesBytes(Directory, Filter: String): Int64;

  // Others :
  function RichTextToText(const rtfText: String): string;       // rtfText can be rtf or not rtf text !

  function TextToRichText(const aText: String): string;   // aText can be rtf or not rtf text !

  procedure Textfile_Add(OnTextFile: TFilename; const AddText: String; const CleanBefore: Boolean);

  {$IFDEF DELPHIXE2_OR_ABOVE}
  procedure GetFileDelimiters(const FileName: string; var DriveDelimiter: ansistring; var PathDelimiter: char; const DelimiterMode: TDelimiterMode = delimOSPlatorm);
  function ChangeFileExt(const FileName, Extension: string; const DelimiterMode: TDelimiterMode = delimOSPlatorm): string;
  function ExtractFileName(const FileName: string; const DelimiterMode: TDelimiterMode = delimOSPlatorm): string;
  function ExtractFileExt(const FileName: string; const DelimiterMode: TDelimiterMode = delimOSPlatorm): string;
  function ExtractFileDir(const FileName: string; const DelimiterMode: TDelimiterMode = delimOSPlatorm): string;
  function ExtractFilePath(const FileName: string; const DelimiterMode: TDelimiterMode = delimOSPlatorm): string;

  procedure ZipDirectory(const SourceDir: string; ToZipStream: TStream; ZipSubdirectories: string = ''; Compression: TZipCompression = zcDeflate; ZipProgress: TZipProgressEvent = Nil); overload;
  procedure ZipDirectory(const SourceDir, ToZipFile: string; ZipSubdirectories: string = ''; Compression: TZipCompression = zcDeflate; ZipProgress: TZipProgressEvent = Nil); overload;
  procedure ZipFile(const SourceFile, ArchiveSourceFilename, ToZipFile: string; OpenMode: TZipMode = zmWrite);
  procedure UnZipFile(const ArchiveName, ToPath: String);
  {$ENDIF}

  {$IFDEF UNICODE}
  function GetStreamEncoding(aStream: TStream): TEncoding;
  function GetFileEncoding(const FromFile: TFilename): TEncoding;
  function IsStreamEncodedWith(aStream: TStream; Encoding: TEncoding): Boolean;
  function StreamToRawByteString(aStream: TStream): RawByteString;   //  type RawByteString = AnsiString;
  function String_LoadFromFileDetectEncoding(const FromFile: TFilename; const Mode: Word = fmOpenRead): string;
  {$ENDIF}


const
  // Privilege constants to use with NTSetPrivilege() :
  SE_CREATE_TOKEN_NAME = 'SeCreateTokenPrivilege';
  SE_ASSIGNPRIMARYTOKEN_NAME = 'SeAssignPrimaryTokenPrivilege';
  SE_LOCK_MEMORY_NAME = 'SeLockMemoryPrivilege';
  SE_INCREASE_QUOTA_NAME = 'SeIncreaseQuotaPrivilege';
  SE_UNSOLICITED_INPUT_NAME = 'SeUnsolicitedInputPrivilege';
  SE_MACHINE_ACCOUNT_NAME = 'SeMachineAccountPrivilege';
  SE_TCB_NAME = 'SeTcbPrivilege';
  SE_SECURITY_NAME = 'SeSecurityPrivilege';
  SE_TAKE_OWNERSHIP_NAME = 'SeTakeOwnershipPrivilege';
  SE_LOAD_DRIVER_NAME = 'SeLoadDriverPrivilege';
  SE_SYSTEM_PROFILE_NAME = 'SeSystemProfilePrivilege';
  SE_SYSTEMTIME_NAME = 'SeSystemtimePrivilege';
  SE_PROF_SINGLE_PROCESS_NAME = 'SeProfileSingleProcessPrivilege';
  SE_INC_BASE_PRIORITY_NAME = 'SeIncreaseBasePriorityPrivilege';
  SE_CREATE_PAGEFILE_NAME = 'SeCreatePagefilePrivilege';
  SE_CREATE_PERMANENT_NAME = 'SeCreatePermanentPrivilege';
  SE_BACKUP_NAME = 'SeBackupPrivilege';
  SE_RESTORE_NAME = 'SeRestorePrivilege';
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
  SE_DEBUG_NAME = 'SeDebugPrivilege';
  SE_AUDIT_NAME = 'SeAuditPrivilege';
  SE_SYSTEM_ENVIRONMENT_NAME = 'SeSystemEnvironmentPrivilege';
  SE_CHANGE_NOTIFY_NAME = 'SeChangeNotifyPrivilege';
  SE_REMOTE_SHUTDOWN_NAME = 'SeRemoteShutdownPrivilege';
  SE_UNDOCK_NAME = 'SeUndockPrivilege';
  SE_SYNC_AGENT_NAME = 'SeSyncAgentPrivilege';
  SE_ENABLE_DELEGATION_NAME = 'SeEnableDelegationPrivilege';
  SE_MANAGE_VOLUME_NAME = 'SeManageVolumePrivilege';

implementation

procedure SortArrayOfIntegers(var aArray: Array of Integer);
var
  p1, p2, sav: Integer;
begin
  for p1 := Length(aArray)-1 downto 1 do   // Starting from the end allow us to read Length(aArray) just one time !
    for p2 := p1 - 1 downto 0 do           // Find max integer
      if aArray[p1] < aArray[p2] then
      begin
        Sav := aArray[p1];
        aArray[p1] := aArray[p2];
        aArray[p2] := Sav;
      end;
end;

function IsFolder(SRec: TSearchrec): Boolean;
begin
  Result := SRec.Attr and faDirectory <> 0;
end;

function isFolderReadOnly(Directory: String): Boolean;
var
  TmpFile: String;
  Seq: Integer;
  Fich: TextFile;
begin
  Result := True;

  if Directory <> '' then
    if sysUtils.DirectoryExists(Directory) then
    begin
      if Directory[length(Directory)] <> '\' then
        Directory := Directory + '\';

      Seq := 1;
      repeat
        TmpFile := Directory + '~tmp' + intToStr(Seq) + '.txt';
        Seq := Seq + 1;
      until (not FileExists(TmpFile)) or (Seq = 10000);

      if not FileExists(TmpFile)
      then
        try
          AssignFile(Fich, TmpFile);
          Rewrite(Fich);
          CloseFile(Fich);
          Result := false;
          DeleteFile(TmpFile);
        except

        end;
    end;
end;

function DirectoryIsEmpty(Directory: String): Boolean;
var
  SRec: TSearchRec;
begin
  Result := true;
  if Directory <> '' then
    if Directory[length(Directory)] <> '\' then
      Directory := Directory + '\';

  Directory := Directory + '*';

  if FindFirst(Directory, faAnyfile, SRec) = 0 then
    repeat
      if (SRec.Name + '.')[1] <> '.'
      then Result := false;
    until (not Result) or (FindNext(SRec) <> 0);

  FindClose(SRec);
end;

function DirectoryWithSubDir(Directory: String): Boolean;
var
  SRec: TSearchRec;
begin
  Result := false;
  if Directory <> '' then
    if Directory[length(Directory)] <> '\' then
      Directory := Directory + '\';

  Directory := Directory + '*';

  if FindFirst(Directory, faAnyfile, SRec) = 0 then
    repeat
      if IsFolder(SRec)
      then
        if (SRec.Name + '.')[1] <> '.'    // If (SREC.Name + 'X')[1] <> '.'
        then RESULT := true;
    until (Result) or (FindNext(SREC) <> 0);

  FindClose(SREC);
end;

procedure GetSubDirs(FromDirectory: String; aList: TStrings);
var
  SREC: TSearchRec;
begin
  aList.Clear;

  if FromDirectory <> '' then
    if FromDirectory[length(FromDirectory)] <> '\' then
      FromDirectory := FromDirectory + '\';

  FromDirectory := FromDirectory + '*';


  if FindFirst(FromDirectory, faAnyfile, SRec) = 0 then
    repeat
      if IsFolder(SRec)
      then
        if (SRec.Name + '.')[1] <> '.'
        then aList.Add(SRec.Name);
    until FindNext(SRec) <> 0;

  FindClose(SRec);
end;

function DiskFreeBytes(Drv: Char): Int64;
var Valor: Integer;
begin
  Result := -1;   // Disco invalido !
  Valor  := Ord( AnsiUpperCase(Drv)[1] ) - 64;   // A=65, B=66    Etc ...

  if Valor in [1..66] then
    if sysUtils.DirectoryExists(Drv + ':') then
      Result := DiskFree(Valor);      // A=1, B=2   Etc ..
end;

function DiskBytes(Drv: Char): Int64;
var Valor: Byte;
begin
  Result := -1;
  Valor := Ord( AnsiUpperCase(Drv)[1] ) - 64;   // A=65, B=66    Etc ...

  if Valor in [1..66] then
    if sysUtils.DirectoryExists(Drv + ':') then
      Result := DiskSize(Valor);
end;

function GetFileBytes(Filename: String): Int64;
var SRec: TSearchRec;
begin
  if FindFirst(Filename, FaAnyFile, SRec) = 0
  then Result := SRec.Size
  else Result := 0;

  FindClose(SRec);
end;

function GetFilesBytes(Directory, Filter: String): Int64;
var
  SRec: TSearchRec;
begin
  Result := 0;
  if Directory <> '' then
    if Directory[length(Directory)] <> '\' then
      Directory := Directory + '\';

  if FindFirst(Directory + Filter, FaAnyFile, SRec) = 0 then
  begin
    Result := SRec.Size;
    while FindNext(SRec) = 0 do
       Result := Result + SRec.Size;
  end;

  FindClose(SRec);
end;

function RichTextToText(const rtfText: String): string;       // rtfText can be rtf or not rtf text !
var
  aOwner: TForm;
  aRichEdit: TRichEdit;
  aStringStream: TStringStream;
begin
  Result := '';
  if rtfText = '' then Exit;

  Application.CreateForm(TForm, aOwner);
  aRichEdit := TRichEdit.Create(aOwner);

  try
    aStringStream := TStringStream.Create(rtfText);

    try
      aRichEdit.Parent := aOwner;
      aRichEdit.Lines.LoadFromStream(aStringStream);
      Result := aRichEdit.Text;
    finally
      aStringStream.Free;
    end;
  except
  end;

  aRichEdit.Free;
  aOwner.Free;
end;

function TextToRichText(const aText: String): string;   // aText can be rtf or not rtf text !
var
  aOwner: TForm;
  aRichEdit: TRichEdit;
  aStringStream: TStringStream;
begin
  Result := '';
  if aText = '' then Exit;

  Application.CreateForm(TForm, aOwner);
  aRichEdit := TRichEdit.Create(aOwner);

  try
    aStringStream := TStringStream.Create(aText);

    try
      aRichEdit.Parent := aOwner;
      aRichEdit.Lines.LoadFromStream(aStringStream);

      {$IFDEF UNICODE}
      aStringStream.Clear;
      {$ELSE}
      aStringStream.Size := 0;
      aStringStream.Position := 0;
      {$ENDIF}

      aRichEdit.Lines.SaveToStream(aStringStream);
      Result := aStringStream.DataString;
    finally
      aStringStream.Free;
    end;
  except
  end;

  aRichEdit.Free;
  aOwner.Free;
end;

procedure Textfile_Add(OnTextFile: TFilename; const AddText: String; const CleanBefore: Boolean);
var
  aTextFile: TextFile;
  IsEmpty: Boolean;
begin
  try
    AssignFile(aTextFile, OnTextFile);

    if (not FileExists(OnTextFile)) or (CleanBefore)
    then begin
      Rewrite(aTextFile);          // Cria um novo OnTextFile e abre-o ...
      IsEmpty := True;
    end
    else begin
      Reset(aTextFile);            // Abre um OnTextFile existente ...
      IsEmpty := Eof(aTextFile);
    end;

    Append(aTextFile);             // Prepara o OnTextFile para inserção no fim ...

    if not IsEmpty
    then Writeln(aTextFile, '');   // Abre uma nova linha ...

    Write(aTextFile, AddText);       // Escreve na sua posição (Sem abrir uma nova linha no fim) ...
    CloseFile(aTextFile);
  except
  end;
end;

{$IFDEF DELPHIXE2_OR_ABOVE}
procedure GetFileDelimiters(const FileName: string; var DriveDelimiter: ansistring; var PathDelimiter: char; const DelimiterMode: TDelimiterMode = delimOSPlatorm);
begin
  case DelimiterMode of
    delimAuto:
    begin
      PathDelimiter := PathDelim;
      DriveDelimiter := DriveDelim;

      // Linux / FTP :
      if pos('/', FileName) <> 0 then
      begin
        DriveDelimiter := '';
        PathDelimiter := '/';
      end;

      // Priorize Windows if '\' found :
      if pos('\', FileName) <> 0 then
      begin
        DriveDelimiter := ':';
        PathDelimiter := '\';
      end;
    end;

    delimOSPlatorm:
    begin
      DriveDelimiter := DriveDelim;
      PathDelimiter := PathDelim;
    end;

    delimWindows:
    begin
      DriveDelimiter := ':';
      PathDelimiter := '\';
    end;

    delimMacOSLinuxFtp:
    begin
      DriveDelimiter := '';
      PathDelimiter := '/';
    end;
  end;
end;

function ChangeFileExt(const FileName, Extension: string; const DelimiterMode: TDelimiterMode = delimOSPlatorm): string;
var
  PathDelimiter: char;
  DriveDelimiter: ansistring;
  I: Integer;
begin
  GetFileDelimiters(FileName, DriveDelimiter, PathDelimiter, DelimiterMode);

  I := FileName.LastDelimiter('.' + PathDelimiter + DriveDelimiter);
  if (I < 0) or (FileName.Chars[I] <> '.') then I := MaxInt;
  Result := FileName.SubString(0, I) + Extension;
end;

function ExtractFileName(const FileName: string; const DelimiterMode: TDelimiterMode = delimOSPlatorm): string;
var
  PathDelimiter: char;
  DriveDelimiter: ansistring;
  I: Integer;
begin
  GetFileDelimiters(FileName, DriveDelimiter, PathDelimiter, DelimiterMode);

  I := FileName.LastDelimiter(PathDelimiter + DriveDelimiter);
  Result := FileName.SubString(I + 1);
end;

function ExtractFileExt(const FileName: string; const DelimiterMode: TDelimiterMode = delimOSPlatorm): string;
var
  PathDelimiter: char;
  DriveDelimiter: ansistring;
  I: Integer;
begin
  GetFileDelimiters(FileName, DriveDelimiter, PathDelimiter, DelimiterMode);

  I := FileName.LastDelimiter('.' + PathDelimiter + DriveDelimiter);
  if (I >= 0) and (FileName.Chars[I] = '.') then
    Result := FileName.SubString(I)
  else
    Result := '';
end;

function ExtractFileDir(const FileName: string; const DelimiterMode: TDelimiterMode = delimOSPlatorm): string;
var
  PathDelimiter: char;
  DriveDelimiter: ansistring;
  I: Integer;
begin
  GetFileDelimiters(FileName, DriveDelimiter, PathDelimiter, DelimiterMode);

  I := FileName.LastDelimiter(PathDelimiter + DriveDelimiter);
  if (I > 0) and (FileName.Chars[I] = PathDelimiter) and
    (not FileName.IsDelimiter(PathDelimiter + DriveDelimiter, I-1)) then Dec(I);
  Result := FileName.SubString(0, I + 1);
end;

function ExtractFilePath(const FileName: string; const DelimiterMode: TDelimiterMode = delimOSPlatorm): string;
var
  PathDelimiter: char;
  DriveDelimiter: ansistring;
  I: Integer;
begin
  I := FileName.LastDelimiter(PathDelimiter + DriveDelimiter);
  Result := FileName.SubString(0, I + 1);
end;

// TZipFile.ZipDirectoryContents(ToZipFile, SourceDir, Compression) does not handle ZipSubdirectories
procedure ZipDirectory(const SourceDir: string; ToZipStream: TStream; ZipSubdirectories: string = ''; Compression: TZipCompression = zcDeflate; ZipProgress: TZipProgressEvent = Nil);
var
  LZipFile: TMyZipFile;
  LFile: string;
  LZFile: string;
  LPath: string;
  LFiles: TStringDynArray;
begin
  if ZipSubdirectories <> '' then
    ZipSubdirectories := SysUtils.IncludeTrailingPathDelimiter(ZipSubdirectories);

{$IFDEF MSWINDOWS}
  ZipSubdirectories := StringReplace(ZipSubdirectories, '\', '/', [rfReplaceAll]);
{$ENDIF MSWINDOWS}

  LZipFile := TMyZipFile.Create;
  try
    if Assigned(ZipProgress) then
      LZipFile.OnProgress := ZipProgress;
    LFiles := TDirectory.GetFiles(SourceDir, '*', TSearchOption.soAllDirectories);
    LZipFile.Open(ToZipStream, zmWrite);
    LPath := SysUtils.IncludeTrailingPathDelimiter(SourceDir);
    for LFile in LFiles do
    begin
      // Strip off root path
{$IFDEF MSWINDOWS}
      LZFile := StringReplace(Copy(LFile, Length(LPath) + 1, Length(LFile)), '\', '/', [rfReplaceAll]);
{$ELSE}
      LZFile := Copy(LFile, Length(LPath) + 1, Length(LFile));
{$ENDIF MSWINDOWS}
      LZipFile.Add(LFile, ZipSubdirectories + LZFile, Compression);
    end;
    LZipFile.Close;
  finally
    LZipFile.Free;
  end;
end;

// TZipFile.ZipDirectoryContents(ToZipFile, SourceDir, Compression) does not handle ZipSubdirectories
procedure ZipDirectory(const SourceDir, ToZipFile: string; ZipSubdirectories: string = ''; Compression: TZipCompression = zcDeflate; ZipProgress: TZipProgressEvent = Nil);
var
  LZipFile: TMyZipFile;
  LFile: string;
  LZFile: string;
  LPath: string;
  LFiles: TStringDynArray;
begin
  if ZipSubdirectories <> '' then
    ZipSubdirectories := SysUtils.IncludeTrailingPathDelimiter(ZipSubdirectories);

{$IFDEF MSWINDOWS}
  ZipSubdirectories := StringReplace(ZipSubdirectories, '\', '/', [rfReplaceAll]);
{$ENDIF MSWINDOWS}

  LZipFile := TMyZipFile.Create;
  try
    if Assigned(ZipProgress) then
      LZipFile.OnProgress := ZipProgress;
    if TFile.Exists(ToZipFile) then
      TFile.Delete(ToZipFile);
    LFiles := TDirectory.GetFiles(SourceDir, '*', TSearchOption.soAllDirectories);
    LZipFile.Open(ToZipFile, zmWrite);
    LPath := SysUtils.IncludeTrailingPathDelimiter(SourceDir);
    for LFile in LFiles do
    begin
      // Strip off root path
{$IFDEF MSWINDOWS}
      LZFile := StringReplace(Copy(LFile, Length(LPath) + 1, Length(LFile)), '\', '/', [rfReplaceAll]);
{$ELSE}
      LZFile := Copy(LFile, Length(LPath) + 1, Length(LFile));
{$ENDIF MSWINDOWS}
      LZipFile.Add(LFile, ZipSubdirectories + LZFile, Compression);
    end;
    LZipFile.Close;
  finally
    LZipFile.Free;
  end;
end;

procedure ZipFile(const SourceFile, ArchiveSourceFilename, ToZipFile: string; OpenMode: TZipMode = zmWrite);
var
  aZipFile: TZipFile;
begin
  aZipFile := TZipFile.Create;

  if OpenMode = zmReadWrite then
    if not FileExists(ToZipFile) then
      OpenMode := zmWrite;

  try
    aZipFile.Open(ToZipFile, OpenMode);

    // if ArchiveSourceFilename = '' then
    //  ArchiveSourceFilename := ExtractFileName(ArchiveSourceFilename);

    aZipFile.Add(SourceFile, ArchiveSourceFilename);    // We can handle sub dirs like this : ArchiveSourceFilename = 'subdir/myfilename.txt' !
    aZipFile.Close;
  finally
    aZipFile.Free;
  end;
end;

procedure UnZipFile(const ArchiveName, ToPath: String);
var
  aZipFile: TZipFile;
begin
  aZipFile := TZipFile.Create;

  try
    aZipFile.Open(ArchiveName, zmRead);
    aZipFile.ExtractAll(ToPath);
    aZipFile.Close;
  finally
    aZipFile.Free;
  end;
end;
{$ENDIF}

{$IFDEF UNICODE}
// Detect encoding only if BOM (Byte order marks) informed
function GetStreamEncoding(aStream: TStream): TEncoding;
var
  Bytes: TBytes;
  Size: Int64;
begin
  Result := nil;        // 2015-07-06 Avoid XE/64 bit error
  aStream.Seek(0, soFromBeginning);
  Size := aStream.Size;
  SetLength(Bytes, Size);
  aStream.ReadBuffer(Pointer(Bytes)^, Size);
  TEncoding.GetBufferEncoding(Bytes, RESULT);
end;
{$ENDIF}

{$IFDEF UNICODE}
// Detect encoding only if BOM (Byte order marks) informed
function IsStreamEncodedWith(aStream: TStream; Encoding: TEncoding): Boolean;
var
  BOM, Bytes: TBytes;   // Encoding Byte Order Mark ...
  BOMSize: Integer;
begin
  RESULT := false;
  BOM := Encoding.GetPreamble;
  BOMSize := Length(BOM);

  if aStream.Size >= BOMSize
  then begin
    aStream.Seek(0, soFromBeginning);
    SetLength(Bytes, BOMSize);
    aStream.ReadBuffer(Pointer(Bytes)^, BOMSize);

    if CompareMem(@BOM[0], @Bytes[0], BOMSize)
    then RESULT := true;
  end;
end;
{$ENDIF}

{$IFDEF UNICODE}
function StreamToRawByteString(aStream: TStream): RawByteString;   //  type RawByteString = AnsiString;
begin
  SetLength(Result, aStream.Size);
  aStream.Position := 0;
  aStream.Read(PAnsiChar(Result)^, aStream.Size);
end;
{$ENDIF}

{$IFDEF UNICODE}
function GetFileEncoding(const FromFile: TFilename): TEncoding;
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FromFile, fmOpenRead);

  try
    Result := GetStreamEncoding(FileStream); // Retrieve encoding into files with BOM informed ...

    if Result = TEncoding.ANSI then    // May not have detect encoding ...
    begin
      // * Detect encoding without BOM (Byte order marks) informed on file * //

      // false positive :
      // Lpi := IS_TEXT_UNICODE_UNICODE_MASK;
      // if IsTextUnicode(@Stream, Stream.Size, @Lpi) then

      if WideStrUtils.DetectUTF8Encoding( StreamToRawByteString(FileStream) ) = etUTF8 then
        Result := TEncoding.UTF8;
    end;
  finally
    FileStream.Free;
  end;
end;
{$ENDIF}

{$IFDEF UNICODE}
// Load file detecting encoding in files with no BOM (Byte order marks) informed !
function String_LoadFromFileDetectEncoding(const FromFile: TFilename; const Mode: Word = fmOpenRead): string;
var
  DefaultLoad: Boolean;
  FileStream: TFileStream;
  FileEncoding: TEncoding;
  chr: AnsiChar;
begin
  Result := '';
  DefaultLoad := true;
  FileStream := TFileStream.Create(FromFile, Mode);

  try
    FileEncoding := GetStreamEncoding(FileStream); // Retrieve encoding into files with BOM informed ...

    if FileEncoding = TEncoding.ANSI then    // May not have detect encoding ...
    begin
      // * Detect encoding without BOM (Byte order marks) informed on file * //

      // false positive :
      // Lpi := IS_TEXT_UNICODE_UNICODE_MASK;
      // if IsTextUnicode(@Stream, Stream.Size, @Lpi) then

      if WideStrUtils.DetectUTF8Encoding( StreamToRawByteString(FileStream) ) = etUTF8 then
        try
          FileStream.Position := 0;
          while FileStream.Read(chr, 1) = 1 do
            Result := Result + chr;
          DefaultLoad := false;
        except
        end;
    end;

    if DefaultLoad then
    begin
      FileStream.Position := 0;
      while FileStream.Read(chr, 1) = 1 do
        Result := Result + chr;
    end;

  finally
    FileStream.Free;
  end;
end;
{$ENDIF}

end.
