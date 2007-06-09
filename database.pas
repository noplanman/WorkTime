unit database;

interface
uses DBClient;

function insertRow(dataset:TClientDataSet;fieldName,value:String):Boolean;
function valueExists(dataset:TClientDataSet;column,value:String):Boolean;
function saveToFile(dataset:TClientDataSet;fileName:String;format:TDataPacketFormat):Boolean;
function loadFromFile(dataset:TClientDataSet;fileName:String):Boolean;

implementation

uses DB;

function insertRow(dataset:TClientDataSet;fieldName,value:String):Boolean;
begin
  try
    with dataset do
    begin
      Insert;
      FieldByName(fieldName).Value := value;
      Post;
    end;
    result := True;
  except
    result := False;
  end;
end;

function valueExists(dataset:TClientDataSet;column,value:String):Boolean;
begin
  try
    dataset.First;
    while (not dataset.Eof) do
    begin
      if dataset.FieldByName(column).Value = value then
      begin
        result := True;
        Break;
      end;
      dataset.Next;
    end;
    result := False;
  except
    result := False;
  end;
end;

function saveToFile(dataset:TClientDataSet;fileName:String;format:TDataPacketFormat):Boolean;
begin
  try
    dataset.SaveToFile(filename,format);
    result := True;
  except
    result := False;
  end;
end;

function loadFromFile(dataset:TClientDataSet;fileName:String):Boolean;
begin
  try
    dataset.LoadFromFile(filename);
    result := True;
  except
    result := False;
  end;
end;


end.
