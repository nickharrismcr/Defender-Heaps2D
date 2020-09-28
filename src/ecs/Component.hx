package ecs;

interface IComponent
{
	public var typeName:String;
}

class Component implements IComponent
{
	public var typeName:String;
	public function new() {
		this.typeName=Type.getClassName(Type.getClass(this));
	}	
}


 
