ScriptName Venworks:EncountersOverhaul:GlobalConfig Extends ScriptObject Hidden

Struct Creation
  String Name = "Venworks-EncountersOverhaul"
EndStruct

String Function GetCreationName() Global
  Creation mod = new Creation
  Return mod.Name
EndFunction