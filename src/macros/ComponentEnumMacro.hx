package macros;

import haxe.macro.Context;
import haxe.macro.Expr;

// not possible to use macros in this project yet. heaps.io is full of macro calls
// and putting anything that calls a macro in the main loop subclass of hxd.App won't compile, it appears that
// a macro build is running on that class by the time the compiler gets here? 

// no workarounds - e.g putting my macro stuff inside "#if !macro" doesn't work. 
// buggered if I'm going to waste days trying to figure it out. googling compiler error message
// produced 2 matches. 

// class ComponentEnumMacro { 
 
//    #if !macro macro #end static public function build():Array<Field> {
//         var fields = Context.getBuildFields();
//         var buildclass=Context.getLocalClass().get().name;
//         var enum_name=buildclass.substring(0,buildclass.indexOf("Component"));
//         #if !macro
//         var newField = {
//             name: "type",
//             doc: null,
//             meta: [],
//             access: [APublic],
//             kind: FVar(macro:ComponentType, macro $i{enum_name} ),
//             pos: Context.currentPos()
//         };
//         fields.push(newField);
//         #end
//         return fields;
//     }
// } 