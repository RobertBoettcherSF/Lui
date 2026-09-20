--------------------------------------------------------------------
--  Derived from LEA lea_common-syntax.adb                        --
--  Copyright (c) 2017 .. 2026 Gautier de Montmollin              --
--  Adapted for Lui: Copyright (c) 2026 Robert Boettcher          --
--------------------------------------------------------------------

with Ada.Wide_Characters.Handling;

package body Lui_Common.Syntax is

   function Guess_Syntax
     (File_Name, Custom_Filter : UTF_16_String) return Syntax_Type
   is
      use Ada.Wide_Characters.Handling;
      U_Name : constant UTF_16_String := To_Upper (File_Name);
      U_Filt : constant UTF_16_String := To_Upper (Custom_Filter);
   begin
      for S1 in U_Filt'Range loop
         if U_Filt (S1) = '*' then
            for S2 in S1 + 1 .. U_Filt'Last loop
               if S2 = U_Filt'Last or else U_Filt (S2 + 1) = ';' then
                  declare
                     Ext : constant UTF_16_String := U_Filt (S1 + 1 .. S2);
                  begin
                     if U_Name'Length >= Ext'Length
                       and then U_Name
                         (U_Name'Last - Ext'Length + 1 .. U_Name'Last) = Ext
                     then
                        return Ada_Syntax;
                     end if;
                  end;
               end if;
            end loop;
         end if;
      end loop;

      if U_Name'Length > 3 then
         if U_Name (U_Name'Last - 3 .. U_Name'Last - 1) = ".AD" then
            return Ada_Syntax;
         elsif U_Name (U_Name'Last - 3 .. U_Name'Last) = ".GPR" then
            return GPR_Syntax;
         end if;
      end if;
      return Undefined;
   end Guess_Syntax;

   function File_Type_Image (Syn : Syntax_Type) return UTF_16_String is
   begin
      case Syn is
         when Undefined  => return "Text file";
         when Ada_Syntax => return "Ada file";
         when GPR_Syntax => return "GNAT project file";
      end case;
   end File_Type_Image;

end Lui_Common.Syntax;
