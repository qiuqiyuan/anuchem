#ifndef __X10X_VECTOR_VECTOR3D_H
#define __X10X_VECTOR_VECTOR3D_H

#include <x10rt.h>


#define X10_LANG_ANY_H_NODEPS
#include <x10/lang/Any.h>
#undef X10_LANG_ANY_H_NODEPS
#define X10X_VECTOR_TUPLE3D_H_NODEPS
#include <x10x/vector/Tuple3d.h>
#undef X10X_VECTOR_TUPLE3D_H_NODEPS
#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
namespace x10 { namespace lang { 
class String;
} } 
namespace x10 { namespace compiler { 
class Inline;
} } 
namespace x10 { namespace lang { 
class Math;
} } 
namespace x10 { namespace compiler { 
class Native;
} } 
namespace x10 { namespace compiler { 
class NonEscaping;
} } 
namespace x10 { namespace compiler { 
class Synthetic;
} } 

namespace x10x { namespace vector { 

class Vector3d_Strings {
  public:
    static ::x10::lang::String sl__14274;
    static ::x10::lang::String sl__14275;
    static ::x10::lang::String sl__14272;
    static ::x10::lang::String sl__14273;
};

class Vector3d   {
    public:
    RTT_H_DECLS_STRUCT
    
    ::x10x::vector::Vector3d* operator->() { return this; }
    
    x10_double FMGL(i);
    
    x10_double FMGL(j);
    
    x10_double FMGL(k);
    
    static ::x10aux::itable_entry _itables[3];
    
    ::x10aux::itable_entry* _getITables() { return _itables; }
    
    static ::x10::lang::Any::itable< ::x10x::vector::Vector3d > _itable_0;
    
    static ::x10x::vector::Tuple3d::itable< ::x10x::vector::Vector3d > _itable_1;
    
    static ::x10aux::itable_entry _iboxitables[3];
    
    ::x10aux::itable_entry* _getIBoxITables() { return _iboxitables; }
    
    static ::x10x::vector::Vector3d _alloc(){::x10x::vector::Vector3d t; return t; }
    
    /* Static field: FMGL(NULL) */
    static ::x10x::vector::Vector3d FMGL(NULL);
    static void FMGL(NULL__do_init)();
    static void FMGL(NULL__init)();
    static volatile ::x10aux::StaticInitController::status FMGL(NULL__status);
    static ::x10::lang::CheckedThrowable* FMGL(NULL__exception);
    static ::x10x::vector::Vector3d FMGL(NULL__get)();
    
    /* Static field: FMGL(UX) */
    static ::x10x::vector::Vector3d FMGL(UX);
    static void FMGL(UX__do_init)();
    static void FMGL(UX__init)();
    static volatile ::x10aux::StaticInitController::status FMGL(UX__status);
    static ::x10::lang::CheckedThrowable* FMGL(UX__exception);
    static ::x10x::vector::Vector3d FMGL(UX__get)();
    
    /* Static field: FMGL(UY) */
    static ::x10x::vector::Vector3d FMGL(UY);
    static void FMGL(UY__do_init)();
    static void FMGL(UY__init)();
    static volatile ::x10aux::StaticInitController::status FMGL(UY__status);
    static ::x10::lang::CheckedThrowable* FMGL(UY__exception);
    static ::x10x::vector::Vector3d FMGL(UY__get)();
    
    /* Static field: FMGL(UZ) */
    static ::x10x::vector::Vector3d FMGL(UZ);
    static void FMGL(UZ__do_init)();
    static void FMGL(UZ__init)();
    static volatile ::x10aux::StaticInitController::status FMGL(UZ__status);
    static ::x10::lang::CheckedThrowable* FMGL(UZ__exception);
    static ::x10x::vector::Vector3d FMGL(UZ__get)();
    
    void _constructor(x10_double i, x10_double j, x10_double k) {
        
        //#line 17 "/localdisk/qqiu/workspace/anuchem/xla/src/x10x/vector/Vector3d.x10"
        FMGL(i) = i;
        FMGL(j) = j;
        FMGL(k) = k;
        
        //#line 9 "/localdisk/qqiu/workspace/anuchem/xla/src/x10x/vector/Vector3d.x10"
        ::x10x::vector::Vector3d this__12877 = (*this);
        
    }
    static ::x10x::vector::Vector3d _make(x10_double i, x10_double j, x10_double k)
    {
        ::x10x::vector::Vector3d this_; 
        this_->_constructor(i, j, k);
        return this_;
    }
    
    void _constructor(::x10x::vector::Tuple3d* t);
    
    static ::x10x::vector::Vector3d _make(::x10x::vector::Tuple3d* t);
    
    x10_double i() {
        return (*this)->FMGL(i);
        
    }
    x10_double j() {
        return (*this)->FMGL(j);
        
    }
    x10_double k() {
        return (*this)->FMGL(k);
        
    }
    ::x10::lang::String* toString();
    ::x10x::vector::Vector3d __plus(::x10x::vector::Vector3d that);
    ::x10x::vector::Vector3d add(::x10x::vector::Vector3d b);
    static ::x10x::vector::Vector3d __minus(::x10x::vector::Vector3d x,
                                            ::x10x::vector::Vector3d y);
    ::x10x::vector::Vector3d sub(::x10x::vector::Vector3d b);
    x10_double __times(::x10x::vector::Vector3d that);
    x10_double dot(::x10x::vector::Vector3d vec);
    ::x10x::vector::Vector3d cross(::x10x::vector::Vector3d vec);
    ::x10x::vector::Vector3d __times(x10_double that);
    static ::x10x::vector::Vector3d __times(x10_double x, ::x10x::vector::Vector3d y);
    ::x10x::vector::Vector3d mul(x10_double c);
    x10_double mixedProduct(::x10x::vector::Vector3d v2, ::x10x::vector::Vector3d v3);
    x10_double lengthSquared();
    x10_double length();
    x10_double maxNorm();
    x10_double magnitude();
    x10_double angleWith(::x10x::vector::Vector3d vec);
    ::x10x::vector::Vector3d normalize();
    ::x10x::vector::Vector3d inverse();
    static ::x10x::vector::Vector3d __minus(::x10x::vector::Vector3d x);
    ::x10x::vector::Vector3d negate();
    ::x10::lang::String* typeName();
    x10_int hashCode();
    x10_boolean equals(::x10::lang::Any* other);
    x10_boolean equals(::x10x::vector::Vector3d other) {
        return (((::x10aux::struct_equals((*this)->FMGL(i), other->FMGL(i))) &&
        (::x10aux::struct_equals((*this)->FMGL(j), other->FMGL(j)))) &&
        (::x10aux::struct_equals((*this)->FMGL(k), other->FMGL(k))));
        
    }
    x10_boolean _struct_equals(::x10::lang::Any* other);
    x10_boolean _struct_equals(::x10x::vector::Vector3d other) {
        return (((::x10aux::struct_equals((*this)->FMGL(i), other->FMGL(i))) &&
        (::x10aux::struct_equals((*this)->FMGL(j), other->FMGL(j)))) &&
        (::x10aux::struct_equals((*this)->FMGL(k), other->FMGL(k))));
        
    }
    ::x10x::vector::Vector3d x10x__vector__Vector3d____this__x10x__vector__Vector3d(
      ) {
        return (*this);
        
    }
    void __fieldInitializers_x10x_vector_Vector3d() {
     
    }
    
    static void _serialize(::x10x::vector::Vector3d this_, ::x10aux::serialization_buffer& buf);
    
    static ::x10x::vector::Vector3d _deserialize(::x10aux::deserialization_buffer& buf) {
        ::x10x::vector::Vector3d this_;
        this_->_deserialize_body(buf);
        return this_;
    }
    
    void _deserialize_body(::x10aux::deserialization_buffer& buf);
    
};


} } 
#endif // X10X_VECTOR_VECTOR3D_H

namespace x10x { namespace vector { 
class Vector3d;
} } 

#ifndef X10X_VECTOR_VECTOR3D_H_NODEPS
#define X10X_VECTOR_VECTOR3D_H_NODEPS
#include <x10/lang/Any.h>
#include <x10x/vector/Tuple3d.h>
#include <x10/lang/Double.h>
#include <x10/lang/String.h>
#include <x10/compiler/Inline.h>
#include <x10/lang/Math.h>
#include <x10/compiler/Native.h>
#include <x10/compiler/NonEscaping.h>
#include <x10/compiler/Synthetic.h>
#include <x10/lang/Int.h>
#include <x10/lang/Boolean.h>
#include <x10/lang/String.h>
#ifndef X10X_VECTOR_VECTOR3D_H_GENERICS
#define X10X_VECTOR_VECTOR3D_H_GENERICS
inline ::x10x::vector::Vector3d x10x::vector::Vector3d::FMGL(NULL__get)() {
    if (FMGL(NULL__status) != ::x10aux::StaticInitController::INITIALIZED) {
        FMGL(NULL__init)();
    }
    return x10x::vector::Vector3d::FMGL(NULL);
}

inline ::x10x::vector::Vector3d x10x::vector::Vector3d::FMGL(UX__get)() {
    if (FMGL(UX__status) != ::x10aux::StaticInitController::INITIALIZED) {
        FMGL(UX__init)();
    }
    return x10x::vector::Vector3d::FMGL(UX);
}

inline ::x10x::vector::Vector3d x10x::vector::Vector3d::FMGL(UY__get)() {
    if (FMGL(UY__status) != ::x10aux::StaticInitController::INITIALIZED) {
        FMGL(UY__init)();
    }
    return x10x::vector::Vector3d::FMGL(UY);
}

inline ::x10x::vector::Vector3d x10x::vector::Vector3d::FMGL(UZ__get)() {
    if (FMGL(UZ__status) != ::x10aux::StaticInitController::INITIALIZED) {
        FMGL(UZ__init)();
    }
    return x10x::vector::Vector3d::FMGL(UZ);
}

#endif // X10X_VECTOR_VECTOR3D_H_GENERICS
#endif // __X10X_VECTOR_VECTOR3D_H_NODEPS
