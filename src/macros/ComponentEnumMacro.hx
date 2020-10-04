// package macros;

// import haxe.macro.Context;
// import haxe.macro.Expr;

// class ComponentEnumMacro { 
 
//    macro static public function build():Array<Field> {
//         var fields = Context.getBuildFields();
//         var buildclass=Context.getLocalClass().get().name;
//         var enum_name=buildclass.substring(0,buildclass.indexOf("Component"));
//         var newField = {
//             name: "type",
//             doc: null,
//             meta: [],
//             access: [APublic],
//             kind: FVar(macro:ComponentType, macro $i{enum_name} ),
//             pos: Context.currentPos()
//         };
//         fields.push(newField);
//         return fields;
//     }
// } 