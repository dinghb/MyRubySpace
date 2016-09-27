
# 类定义和初始化====================================
  class  Person 
    def  initialize( name, age=18 ) 
      @name = name 
      @age = age 
      @motherland = "China" 
    end  # 初始化方法结束  
    
    def  talk 
      puts "my name is "+@name+", age is "+@age.to_s 
      if  @motherland == "China" 
        puts "I am a Chinese." 
      else 
        puts "I am a foreigner." 
      end 
    end  # talk 方法结束 
    attr_writer :motherland 
  end   # Person 类结束   
  p1=Person.new("kaichuan",20) 
  p1.talk  
  # 继承性====================================
  class Student < Person 
    def  talk 
      puts "I am a student. my name is "+@name+", age is "+@age.to_s 
    end  # talk 方法结束 
  end  # Student 类结束 
  p3=Student.new("kaichuan",25);
  p3.talk 
  p4=Student.new("Ben"); 
  p4.talk  
   #多态性====================================
  class  Worker < Person   
    def talk 
      puts "I am a worker. my name is "+@name+", age is "+@age.to_s 
    end  # talk 方法结束 
  end    # Worker类结束 
  p5=Worker.new("kaichuan",30);p5.talk 
  p6=Worker.new("Ben");p6.talk
#code output:
#my name is kaichuan, age is 20
#I am a Chinese.
#I am a student. my name is kaichuan, age is 25
#I am a student. my name is Ben, age is 18
#I am a worker. my name is kaichuan, age is 30
#I am a worker. my name is Ben, age is 18
---------------------------

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap7.1 定义一个简单类 =====================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

---------------------------
class hello
end
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap7.1 定义一个简单类 =====================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

---------------------------
class hello
end
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap7.1 定义一个简单类 =====================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

---------------------------
def hello
end
p = Point.new # Instantiating a Point
p.class       # => Point
p.is_a? Point # => true
---------------------------
# Ruby中是通过一个initialize方法实现初始化
class Point
  def initialize(x,y)
    @x, @y = x, y
  end
end

p = Point.new(0,0)
---------------------------
# 错误的代码：Ruby中变量是不用声明并赋初值的！
# Incorrect code!
class Point
  @x = 0   # Create instance variable @x and assign a default. WRONG!
  @y = 0   # Create instance variable @y and assign a default. WRONG!

  def initialize(x,y)
    @x, @y = x, y   # Now initialize previously created @x and @y.
  end
end
---------------------------
# 重写（override）一个to_s方法。自定义输出格式
class Point
  def initialize(x,y)
    @x, @y = x, y
  end

  def to_s        # Return a String that represents this point
    "(#@x,#@y)"   # Just interpolate the instance variables into a string
  end
end

p = new Point(1,2)   # Create a new Point object
puts p               # Displays "(1,2)"
---------------------------
# 访问器和属性 Accessor and Attributes
class Point
  def initialize(x,y)
    @x, @y = x, y
  end

  def x           # The accessor (or getter) method for @x
    @x
  end

  def y           # The accessor method for @y
    @y
  end
end

p = Point.new(1,2)
q = Point.new(p.x*2, p.y*3)
---------------------------
# 可变类
class MutablePoint
  def initialize(x,y); @x, @y = x, y; end

  def x; @x; end       # The getter method for @x
  def y; @y; end       # The getter method for @y

  def x=(value)        # The setter method for @x
    @x = value
  end

  def y=(value)        # The setter method for @y
    @y = value
  end
end

p = Point.new(1,1)     # 使用initialize方法初始化
p.x = 0                # 调用Setter的方法
p.y = 0
---------------------------
class Point
  attr_accessor :x, :y # Define accessor methods for our instance variables
end
---------------------------
class Point
  attr_reader :x, :y  # Define reader methods for our instance variables
end
---------------------------
attr_reader "x", "y"
---------------------------
attr :x        # Define a trivial getter method x for @x
attr :y, true  # Define getter and setter methods for @y
---------------------------
# 重定义操作符
class Point
  attr_reader :x, :y   # Define accessor methods for our instance variables

  def initialize(x,y)
    @x,@y = x, y
  end

  def +(other)         # Define + to do vector addition
    Point.new(@x + other.x, @y + other.y)
  end

  def -@               # Define unary minus to negate both coordinates
    Point.new(-@x, -@y)
  end

  def *(scalar)        # Define * to perform scalar multiplication
    Point.new(@x*scalar, @y*scalar)
  end
end
---------------------------
# 当我们试图给一个点加上3时，会产生以下错误信息
NoMethodError: undefined method `x' for 3:Fixnum
        from ./point.rb:37:in `+'
---------------------------
def +(other)
  raise TypeError, "Point argument expected" unless other.is_a? Point
  Point.new(@x + other.x, @y + other.y)
end
---------------------------
def +(other)
  raise TypeError, "Point-like argument expected" unless
    other.respond_to? :x and other.respond_to? :y
  Point.new(@x + other.x, @y + other.y)
end
---------------------------
def +(other)         # Assume that other looks like a Point
  Point.new(@x + other.x, @y + other.y)
rescue               # If anything goes wrong above
  raise TypeError,   # Then raise our own exception
    "Point addition with an argument that does not quack like a Point!"
end
---------------------------
# 如果我们想要让2*p和p*2返回同样的结果，可以定义一个coerce方法
# If we try passing a Point to the * method of an Integer, it will call
# this method on the Point and then will try to multiply the elements of 
# the array. Instead of doing type conversion, we switch the order of
# the operands, so that we invoke the * method defined above.
def coerce(other)
  [self, other]
end
---------------------------
# 为Point对象定义一个[]方法，是Point对象就像一个长度为2的只读数组
# 或一个具有主键的:x和:y的只读哈希表。
# Define [] method to allow a Point to look like an array or
# a hash with keys :x and :y
def [](index)
  case index
  when 0, -2: @x         # Index 0 (or -2) is the X coordinate
  when 1, -1: @y         # Index 1 (or -1) is the Y coordinate
  when :x, "x": @x       # Hash keys as symbol or string for X
  when :y, "y": @y       # Hash keys as symbol or string for Y
  else nil               # Arrays and hashes just return nil on bad indexes
  end
end
---------------------------
# 枚举坐标值Point的方法 Enumerating Coordinates

# This iterator passes the X coordinate to the associated block, and then
# passes the Y coordinate, and then returns. It allows us to enumerate
# a point as if it were an array with two elements. This each method is
# required by the Enumerable module.
def each
  yield @x
  yield @y
end
---------------------------
# 定义了上面的迭代器方法后
p = Point.new(1,2)
p.each {|x| print x }   # Prints "12"
---------------------------
include Enumerable
# 此外，定义了上面的迭代器方法后，我们可以混入Enumerable模块的一些方法。
# Is the point P at the origin?
p.all? {|x| x == 0 } # True if the block is true for all elements
---------------------------
# Point对象的相等性判断。
# 要重写'=='操作符。
def ==(o)               # Is self == o?
  if o.is_a? Point      # If o is a Point object
    @x==o.x && @y==o.y  # then compare the fields.
  elsif                 # If o is not a Point
    false               # then, by definition, self != o.
  end
end
---------------------------
# 更宽松的等价性实现支持duck typing。
def ==(o)                  # Is self == o?
  @x == o.x && @y == o.y   # Assume o has proper x and y methods
rescue                     # If that assumption fails
  false                    # Then self != o
end
---------------------------
# 但我们希望eql?方法与==具有相同的工作方式时，使用别名
class Point
  alias eql? ==
end
---------------------------
# 当我们需要类定义eql?方法进行更严格的相等性测试时，重写eql?方法。
def eql?(o)             
  if o.instance_of? Point      
    @x.eql?(o.x) && @y.eql?(o.y)
  elsif
    false
  end
end
---------------------------
# 这个hash生成的问题在于，它对（1,0）和(0,1)返回同样的哈希码
def hash
  @x.hash + @y.hash
end
---------------------------
# 这个通用的生成hash码的方式适用于绝大多数的Ruby类。
def hash
  code = 17
  code = 37*code + @x.hash
  code = 37*code + @y.hash
  # Add lines like this for each significant instance variable
  code  # Return the resulting code
end
---------------------------
# 对Point进行排序，类似于实现java中的比较器。
include Comparable   # Mix in methods from the Comparable module.

# Define an ordering for points based on their distance from the origin.
# This method is required by the Comparable module.
def <=>(other)
  return nil unless other.instance_of? Point
  @x**2 + @y**2 <=> other.x**2 + other.y**2
end
---------------------------
p,q = Point.new(1,0), Point.new(0,1)
p == q        # => false: p is not equal to q
p < q         # => false: p is not less than q
p > q         # => false: p is not greater than q
---------------------------
# 可变的Point类
attr_accessor :x, :y

# 可变版本
def add!(p)          # Add p to self, return modified self
  @x += p.x
  @y += p.y
  self
end

# 其不可变版本的方法
def add(p)           # A nonmutating version of add!
  q = self.dup       # Make a copy of self
  q.add!(p)          # Invoke the mutating method on the copy
end
---------------------------
# 轻松快速创建可变类的方法
Struct.new("Point", :x, :y)  # Creates new class Struct::Point
Point = Struct.new(:x, :y)   # Creates new class, assigns to Point
---------------------------
# 语句“Point = Struct.new(:x, :y)”的背后原理，命名匿名类。
C = Class.new   # A new class with no body, assigned to a constant
c = C.new       # Create an instance of the class
c.class.to_s    # => "C": constant name becomes class name
---------------------------
Point = Struct.new(:x, :y)   # Creates new class, assigns to Point
p = Point.new(1,2)   # => #<struct Point x=1, y=2>
p.x                  # => 1 
p.y                  # => 2
p.x = 3              # => 3
p.x                  # => 3

# Struct类定义了[]和[]=，即数组和哈希方式索引，甚至提供了迭代器
p[:x] = 4             # => 4: same as p.x =
p[:x]                 # => 4: same as p.x
p[1]                  # => 2: same as p.y
p.each {|c| print c}  # prints "42"
p.each_pair {|n,c| print n,c }   # prints "x4y2"

# 其余提供方法
q = Point.new(4,2)
q == p        # => true
h = {q => 1}  # Create a hash using q as a key
h[p]          # => 1: extract value using p as key
q.to_s        # => "#<struct Point x=4, y=2>"
---------------------------
# Struct类不会为向自定义的Point类提供与点有关的方法，需要我们自定义。
Point = Struct.new(:x, :y)   # Create new class, assign to Point
class Point                  # Open Point class for new methods
  def add!(other)            # Define an add! method
    self.x += other.x
    self.y += other.y
    self
  end

  include Comparable         # Include a module for the class
  def <=>(other)             # Define the <=> operator
    return nil unless other.instance_of? Point
    self.x**2 + self.y**2 <=> other.x**2 + other.y**2
  end
end
---------------------------
# 简单的将Struct类变成不可变类的方法
Point = Struct.new(:x, :y)  # Define mutable class
class Point                 # Open the class
  undef x=,y=,[]=           # Undefine mutator methods
end

---------------------------
# 类方法，类似于Java的静态方法

# 类方法的调用形式举例
total = Point.sum(p1, p2, p3)  # p1, p2 and p3 are Point objects

# Class Method方法的定义方法
class Point
  attr_reader :x, :y     # Define accessor methods for our instance variables

  def Point.sum(*points) # Return the sum of an arbitrary number of points
    x = y = 0
    points.each {|p| x += p.x; y += p.y }
    Point.new(x,y)
  end

  # ...the rest of class omitted here...
end
---------------------------
# 类方法还可以使用以下方法定义
# 该方法虽然没有Point.sum(*points)方式清晰，但是满足类DRY(Don't Repeat Yourself)
# 即不重复自己原则————使用self而不是类名，在改变类名时，无须修改类方法的定义。
def self.sum(*points)  # Return the sum of an arbitrary number of points
  x = y = 0
  points.each {|p| x += p.x; y += p.y }
  Point.new(x,y)
end
---------------------------
# 更加复杂的Class Method定义，在定义多个类方法时，它更加方便
# Open up the Point object so we can add methods to it
class << Point      # Syntax for adding methods to a single object
  def sum(*points)  # This is the class method Point.sum
    x = y = 0
    points.each {|p| x += p.x; y += p.y }
    Point.new(x,y)
  end

  # Other class methods can be defined here
end

# 这种Class Method定义技术也可以在类定义体中使用，这儿用self代替类名：
class Point
  # Instance methods go here

  class << self
    # Class methods go here
  end
end
---------------------------
# 7.1.15 常量 Constants
class Point
  def initialize(x,y)  # Initialize method
    @x,@y = x, y 
  end

  ORIGIN = Point.new(0,0)
  UNIT_X = Point.new(1,0)
  UNIT_Y = Point.new(0,1)

  # Rest of class definition goes here
end

# 在定义体外访问常量需要使用类名做前缀
Point::UNIT_X + Point::UNIT_Y   # => (1,1)

# 可以在类外定义这些常量
Point::NEGATIVE_UNIT_X = Point.new(-1,0)
---------------------------
# 7.1.16 类变量 class variables

# 计算平均坐标值————使用类变量版本
class Point
  # Initialize our class variables in the class definition itself
  @@n = 0              # How many points have been created
  @@totalX = 0         # The sum of all X coordinates
  @@totalY = 0         # The sum of all Y coordinates

  def initialize(x,y)  # Initialize method
    @x,@y = x, y       # Sets initial values for instance variables

    # Use the class variables in this instance method to collect data
    @@n += 1           # Keep track of how many Points have been created
    @@totalX += x      # Add these coordinates to the totals
    @@totalY += y
  end

  # A class method to report the data we collected
  def self.report
    # Here we use the class variables in a class method
    puts "Number of points created: #@@n"
    puts "Average X coordinate: #{@@totalX.to_f/@@n}"
    puts "Average Y coordinate: #{@@totalY.to_f/@@n}"
  end
end
---------------------------
# 7.1.16 类实例变量 Class Instance Variables
# 类实例变量————类对象的实例变量

# 计算平均坐标值————使用类实例变量版本
class Point
  # Initialize our class instance variables in the class definition itself
  @n = 0              # How many points have been created
  @totalX = 0         # The sum of all X coordinates
  @totalY = 0         # The sum of all Y coordinates

  def initialize(x,y) # Initialize method 
    @x,@y = x, y      # Sets initial values for instance variables
  end

  def self.new(x,y)   # Class method to create new Point objects
    # Use the class instance variables in this class method to collect data
    @n += 1           # Keep track of how many Points have been created
    @totalX += x      # Add these coordinates to the totals
    @totalY += y

    super             # Invoke the real definition of new to create a Point
                      # More about super later in the chapter
  end

  # A class method to report the data we collected
  def self.report
    # Here we use the class instance variables in a class method
    puts "Number of points created: #@n"
    puts "Average X coordinate: #{@totalX.to_f/@n}"
    puts "Average Y coordinate: #{@totalY.to_f/@n}"
  end
end
---------------------------
# Another Way to Initialize our class instance variables
class << self
  attr_accessor :n, :totalX, :totalY
end
---------------------------

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap7.2 方法可见性 =====================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

---------------------------
# 使用默认格式的可见性定义方法
class Point
  # public methods go here，it is default

  # The following methods are protected
  protected

  # protected methods go here

  # The following methods are private
  private

  # private methods go here
end
---------------------------
# 在紧接着方法定义后面，声明方法的可见性。
# 也可以在类的末尾处一次性声明所有私有和保护方法
class Widget
  def x                       # Accessor method for @x
    @x
  end
  protected :x                # Make it protected

  def utility_method          # Define a method
    nil
  end
  private :utility_method     # And make it private
end
---------------------------
# 把一个类方法声明为私有，比如某个类要定义工厂方法，需要将new方法私有
private_class_method :new
# 也可用public_class_method 方法把一个私有类方法再次变成公开方法。
public_class_method :new
---------------------------
# 调用私有方法或被保护方法。详情见第8章
w = Widget.new                      # Create a Widget
w.send :utility_method              # Invoke private method!
w.instance_eval { utility_method }  # Another way to invoke it
w.instance_eval { @x }              # Read instance variable of w
---------------------------


#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# chap7.3 子类化和继承 =====================================

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

---------------------------
class Point3D < Point    # Define class Point3D as a subclass of Point
end
---------------------------
# 子类化一个Struct
class Point3D < Struct.new("Point3D", :x, :y, :z)
  # Superclass struct gives us accessor methods, ==, to_s, etc.
  # Add point-specific methods here
end

# 不同于Java的构造方法不可不可继承，Ruby的initiatize方法只是一个普通方法
# 可以像其他方法一个被继承
p2 = Point.new(1,2)
p3 = Point3D.new(1,2)
print p2.to_s, p2.class   # prints "(1,2)Point"
print p3.to_s, p3.class   # prints "(1,2)Point3D"
---------------------------
# 7.3.2 覆盖方法
# 私有方法的覆盖————私有方法不能在所定义的类外被调用，但他们会被子类继承，也就能被覆盖
# 因此，要小心子类化别人写的类

o = Object.new
puts o.to_s      # Prints something like "#<Object:0xb7f7fce4>"
---------------------------
# 方法调用并非在解析时进行绑定，而是在运行时进行绑定的。
# 下面代码输出“Hola World”而不是“Hello World”

# Greet the World
class WorldGreeter
  def greet                      # Display a greeting
    puts "#{greeting} #{who}"
  end

  def greeting                   # What greeting to use
    "Hello"
  end

  def who                        # Who to greet
    "World"
  end
end

# Greet the world in Spanish
class SpanishWorldGreeter < WorldGreeter
  def greeting                   # Override the greeting
    "Hola"
  end
end

# We call a method defined in WorldGreeter, which calls the overridden
# version of greeting in SpanishWorldGreeter, and prints "Hola World"
SpanishWorldGreeter.new.greet
---------------------------
# 抽象方法的定义和其具体类实现，

# This class is abstract; it doesn't define greeting or who
# No special syntax is required: any class that invokes methods that are
# intended for a subclass to implement is abstract.
class AbstractGreeter
  def greet
    puts "#{greeting} #{who}"
  end
end

# A concrete(具体) subclass
class WorldGreeter < AbstractGreeter
  def greeting; "Hello"; end
  def who; "World"; end
end

WorldGreeter.new.greet  # Displays "Hello World"
---------------------------
# 链式调用（Chaining）————扩展而非完全取代一个覆盖的方法，即只想增加一些新代码对
# 其行为进行扩展。
class Point3D < Point
  def initialize(x,y,z)
    # Pass our first two arguments along to the superclass initialize method
    super(x,y)
    # And deal with the third argument ourself
    @z = z;
  end
end
---------------------------
# 类方法的继承——因为Point3D.sum和Point.sum类方法（注：Point3D继承自Point，而sum为
# Point类的类方法）将调用同一个方法。因此，为了避免代码维护者看到Point3D.sum方法后
# 在Point3D类中查找，实际上sum方法的定义在Point类中。Ruby建议应该总是通过定义时所在的
# 类来定义类方法
---------------------------
class Point3D < Point
  def initialize(x,y,z)
    super(x,y)
    @z = z;
  end

  def to_s
    "(#@x, #@y, #@z)"  # Variables @x and @y inherited?
  end
end
---------------------------
Point3D.new(1,2,3).to_s  # => "(1, 2, 3)"
---------------------------
class A
  @@value = 1                   # A class variable
  def A.value; @@value; end     # An accessor method for it
end
print A.value                   # Display value of A's class variable
class B < A; @@value = 2; end   # Subclass alters shared class variable
print A.value                   # Superclass sees altered value
class C < A; @@value = 3; end   # Another alters shared variable again
print B.value                   # 1st subclass sees value from 2nd subclass
---------------------------
ORIGIN = Point3D.new(0,0,0)
---------------------------
def new(*args)
  o = self.allocate   # Create a new object of this class
  o.initialize(*args) # Call the object's initialize method with our args
  o                   # Return new object; ignore return value of initialize
end
---------------------------
class Point
  # Initialize a Point with two or three coordinates
  def initialize(x, y, z=nil)
    @x,@y,@z = x, y, z
  end
end
---------------------------
class Point
  # Define an initialize method as usual...
  def initialize(x,y)  # Expects Cartesian coordinates
    @x,@y = x,y
  end

  # But make the factory method new private
  private_class_method :new

  def Point.cartesian(x,y)  # Factory method for Cartesian coordinates
    new(x,y)  # We can still call new from other class methods
  end

  def Point.polar(r, theta) # Factory method for polar coordinates
    new(r*Math.cos(theta), r*Math.sin(theta))
  end
end
---------------------------
class Point                 # A point in n-space
  def initialize(*coords)   # Accept an arbitrary # of coordinates
    @coords = coords        # Store the coordinates in an array
  end

  def initialize_copy(orig) # If someone copies this Point object
    @coords = @coords.dup   # Make a copy of the coordinates array, too
  end
end
---------------------------
class Season
  NAMES = %w{ Spring Summer Autumn Winter }  # Array of season names
  INSTANCES = []                             # Array of Season objects

  def initialize(n)  # The state of a season is just its 
    @n = n           # index in the NAMES and INSTANCES arrays
  end

  def to_s           # Return the name of a season 
    NAMES[@n]
  end

  # This code creates instances of this class to represent the seasons 
  # and defines constants to refer to those instances.
  # Note that we must do this after initialize is defined.
  NAMES.each_with_index do |name,index|
    instance = new(index)         # Create a new instance
    INSTANCES[index] = instance   # Save it in an array of instances
    const_set name, instance      # Define a constant to refer to it
  end

  # Now that we have created all the instances we'll ever need, we must
  # prevent any other instances from being created
  private_class_method :new,:allocate  # Make the factory methods private
  private :dup, :clone                 # Make copying methods private
end
---------------------------
class Point                  # A point in n-space
  def initialize(*coords)    # Accept an arbitrary # of coordinates
    @coords = coords         # Store the coordinates in an array
  end

  def marshal_dump           # Pack coords into a string and marshal that
    @coords.pack("w*")
  end

  def marshal_load(s)        # Unpack coords from unmarshaled string
    @coords = s.unpack("w*") # and use them to initialize the object
  end
end
---------------------------
class Season
  # We want to allow Season objects to be marshaled, but we don't
  # want new instances to be created when they are unmarshaled.
  def _dump(limit)         # Custom marshaling method
    @n.to_s                # Return index as a string
  end

  def self._load(s)        # Custom unmarshaling method
    INSTANCES[Integer(s)]  # Return an existing instance
  end
end
---------------------------
require 'singleton'           # Singleton module is not built-in

class PointStats              # Define a class
  include Singleton           # Make it a singleton

  def initialize              # A normal initialization method
    @n, @totalX, @totalY = 0, 0.0, 0.0
  end

  def record(point)           # Record a new point
    @n += 1
    @totalX += point.x
    @totalY += point.y
  end

  def report                  # Report point statistics
    puts "Number of points created: #@n"
    puts "Average X coordinate: #{@totalX/@n}"
    puts "Average Y coordinate: #{@totalY/@n}"
  end
end
---------------------------
def initialize(x,y)
  @x,@y = x,y
  PointStats.instance.record(self)
end
---------------------------
PointStats.instance.report
---------------------------
def base64_encode
end

def base64_decode
end
---------------------------
module Base64
  def self.encode
  end

  def self.decode
  end
end
---------------------------
module Base64
  def Base64.encode
  end

  def Base64.decode
  end
end
---------------------------
# This is how we invoke the methods of the Base64 module
text = Base64.encode(data)
data = Base64.decode(text)
---------------------------
module Base64
  DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' \
           'abcdefghijklmnopqrstuvwxyz' \
           '0123456789+/'
end
---------------------------
module Base64
  DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

  class Encoder
    def encode
    end
  end

  class Decoder
    def decode
    end
  end

  # A utility function for use by both classes
  def Base64.helper
  end
end
---------------------------
class Point
  include Comparable
end
---------------------------
class Point
  include(Comparable)
end
---------------------------
include Enumerable, Comparable
---------------------------
"text".is_a? Comparable         # => true
Enumerable === "text"           # => true in Ruby 1.8, false in 1.9
---------------------------
"text".instance_of? Comparable  # => false
---------------------------
module Iterable       # Classes that define next can include this module
  include Enumerable          # Define iterators on top of each
  def each                    # And define each on top of next
    loop { yield self.next }
  end
end
---------------------------
countdown = Object.new       # A plain old object
def countdown.each           # The each iterator as a singleton method
  yield 3
  yield 2
  yield 1
end
countdown.extend(Enumerable) # Now the object has all Enumerable methods  
print countdown.sort         # Prints "[1, 2, 3]"
---------------------------
Math.sin(0)    # => 0.0: Math is a namespace 
include 'Math' # The Math namespace can be included
sin(0)         # => 0.0: Now we have easy access to the functions
---------------------------
/usr/lib/site_ruby/1.8
/usr/lib/site_ruby/1.8/i386-linux
/usr/lib/site_ruby
/usr/lib/ruby/1.8
/usr/lib/ruby/1.8/i386-linux
.
---------------------------
/usr/local/lib/ruby/gems/1.9/gems/rake-0.7.3/lib
/usr/local/lib/ruby/gems/1.9/gems/rake-0.7.3/bin
/usr/local/lib/ruby/site_ruby/1.9
/usr/local/lib/ruby/site_ruby/1.9/i686-linux
/usr/local/lib/ruby/site_ruby
/usr/local/lib/ruby/vendor_ruby/1.9
/usr/local/lib/ruby/vendor_ruby/1.9/i686-linux
/usr/local/lib/ruby/vendor_ruby
/usr/local/lib/ruby/1.9
/usr/local/lib/ruby/1.9/i686-linux
.
---------------------------
# Remove the current directory from the load path
$:.pop if $:.last == '.'  

# Add the installation directory for the current program to 
# the beginning of the load path
$LOAD_PATH.unshift File.expand_path($PROGRAM_NAME)

# Add the value of an environment variable to the end of the path
$LOAD_PATH << ENV['MY_LIBRARY_DIRECTORY']
---------------------------
$Util = Util   # Store a reference to this module in a global variable
---------------------------
if Module.nesting.size > 0       # If we're loaded into a wrapper module
  $wrapper = Module.nesting[0]   # Pass the module back to the loading code
end
---------------------------
# Require 'socket' if and when the TCPSocket is first used
autoload :TCPSocket, "socket"
---------------------------
def Point.sum
  # Method body goes here
end
---------------------------
class << Point
  def class_method1      # This is an instance method of the eigenclass.
  end                    # It is also a class method of Point.

  def class_method2
  end
end
---------------------------
class Point
  # instance methods go here

  class << self
    # class methods go here as instance methods of the eigenclass
  end
end
---------------------------
class Point            # Create or open the class Point
class Point3D < Point  # Create a subclass of Point
class << Point         # Open the eigenclass of the object Point
---------------------------
eigenclass = class << o; self; end
---------------------------
class Object
  def eigenclass
    class << self; self; end
  end
end
---------------------------
message = "hello"
message.world
---------------------------
NoMethodError: undefined method `world' for "hello":String
---------------------------
class C
end
---------------------------
c = C.new
---------------------------
def Integer.parse(text)
  text.to_i
end
---------------------------
n = Fixnum.parse("1")
---------------------------
module Kernel
  # Constants defined in Kernel
  A = B = C = D = E = F = "defined in kernel"
end

# Top-level or "global" constants defined in Object
A = B = C = D = E = "defined at toplevel"

class Super
  # Constants defined in a superclass
  A = B = C = D = "defined in superclass"
end

module Included
  # Constants defined in an included module
  A = B = C = "defined in included module"
end

module Enclosing
  # Constants defined in an enclosing module
  A = B = "defined in enclosing module"

  class Local < Super
    include Included

    # Locally defined constant
    A = "defined locally"

    # The list of modules searched, in the order searched
    # [Enclosing::Local, Enclosing, Included, Super, Object, Kernel]
    search = (Module.nesting + self.ancestors + Object.ancestors).uniq

    puts A  # Prints "defined locally"
    puts B  # Prints "defined in enclosing module"
    puts C  # Prints "defined in included module"
    puts D  # Prints "defined in superclass"
    puts E  # Prints "defined at toplevel"
    puts F  # Prints "defined in kernel"
  end
end
---------------------------
