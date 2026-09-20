--------------------------------------------------------------------
--  Derived from LEA lea_common-user_options.adb (partial)        --
--  Copyright (c) 2017 .. 2026 Gautier de Montmollin              --
--  Adapted for Lui: Copyright (c) 2026 Robert Boettcher          --
--------------------------------------------------------------------

package body Lui_Common.User_Options is

   procedure Toggle_Show_Special (O : in out Option_Pack_Type) is
   begin
      if O.Show_Special = Show_Special_Symbol_Mode'Last then
         O.Show_Special := Show_Special_Symbol_Mode'First;
      else
         O.Show_Special := Show_Special_Symbol_Mode'Succ (O.Show_Special);
      end if;
   end Toggle_Show_Special;

   function Clamp_Int (Value, Lo, Hi : Integer) return Integer is
   begin
      if Value < Lo then
         return Lo;
      elsif Value > Hi then
         return Hi;
      else
         return Value;
      end if;
   end Clamp_Int;

   procedure Clamp_Options (O : in out Option_Pack_Type) is
   begin
      O.Indentation :=
        Clamp_Int (O.Indentation, Indentation_Min, Indentation_Max);
      O.Tab_Width := Clamp_Int (O.Tab_Width, Tab_Width_Min, Tab_Width_Max);
      O.Right_Margin :=
        Clamp_Int (O.Right_Margin, Margin_Min, Margin_Max);
   end Clamp_Options;

end Lui_Common.User_Options;
