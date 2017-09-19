/*
 * generated by Xtext 2.11.0
 */
package com.itemis.jbc.tests

import com.google.inject.Inject
import com.itemis.jbc.jbc.ClassFile
import com.itemis.jbc.jbc.ConstantClass
import com.itemis.jbc.jbc.ConstantNameAndType
import com.itemis.jbc.jbc.ConstantUtf8
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.Test
import org.junit.runner.RunWith

import static com.itemis.jbc.binary.ClassFileFactoryAPI.*
import static com.itemis.jbc.binary.TestHelper.*

import static extension com.itemis.jbc.binary.ClassFileAccessAPI.*

@RunWith(XtextRunner)
@InjectWith(JBCInjectorProvider)
class JBCParsingTest {

	@Inject extension ParseHelper<ClassFile> parseClass
	@Inject extension ValidationTestHelper

	@Test
	def void classFileSimple() {
		assertTreeMatches(parse('''
			ClassFile {
				CAFEBABE 0001 0002 0001 ConstantPool {
				}
				0001 0002 0003 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0000 Attributes {
				}
			}
		'''),
			classFile(u4(-889275714), u2(1), u2(2), u2(1), constantPool(), u2(1), null, null, u2(0), interfaces(),
				u2(0), fields(), u2(0), methods(), u2(0), attributes()))
	}

	@Test
	def classFileWithAllConstantPoolEntries() {
		var ConstantUtf8 utf8
		var ConstantClass class
		var ConstantNameAndType nameAndType
		assertTreeMatches(parse('''
			ClassFile {
				CAFEBABE 0001 0002 0011 ConstantPool {
					utf8 01 ""
					integer 02 00000002
					float 03 00000001
					long 05 00000001 00000002
					double 06 00000001 00000002
					class 07 0001
					string 08 0001
					nameAndType 0C 0001 0001
					fieldRef 09 0008 000A
					methodRef 0A 0008 000A
					interfaceMethodRef 0B 0008 000A
					methodHandle 0F 01 000A
					methodType 10 0001
					invoceDynamic 12 0001 000A
				}
				0001 0008 0008 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0000 Attributes {
				}
			}
		'''),
			classFile(u4(-889275714), u2(1), u2(2), u2(17),
				constantPool(utf8 = constantUtf8(u1(1), uString("")), constantInteger(u1(2), u4(2)),
					constantFloat(u1(3), u4(1)), constantLong(u1(5), u4(1), u4(2)), constantDouble(u1(6), u4(1), u4(2)),
					class = constantClass(u1(7), utf8), constantString(u1(8), utf8),
					nameAndType = constantNameAndType(u1(12), utf8, utf8), constantFieldRef(u1(9), class, nameAndType),
					constantMethodRef(u1(10), class, nameAndType),
					constantInterfaceMethodRef(u1(11), class, nameAndType),
					constantMethodHandle(u1(15), u1(1), nameAndType), constantMethodType(u1(16), utf8),
					constantInvoceDynamic(u1(18), u2(1), nameAndType)), u2(1), class, class, u2(0), interfaces(), u2(0),
				fields(), u2(0), methods(), u2(0), attributes()))
	}

	@Test
	def void classFileWithInterfaces() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0005 ConstantPool {
					utf8 01 ""
					class 07 0001
					class 07 0001
					class 07 0001
				}
				0001 0002 0003 0003 Interfaces {
					0002
					0003
					0004
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0000 Attributes {
				}
			}
		''').assertNoErrors
	}

	@Test
	def void classFileWithFields() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0006 ConstantPool {
					utf8 01 ""
					utf8 01 ""
					utf8 01 ""
					utf8 01 ""
					class 07 0001
				}
				0001 0005 0005 0000 Interfaces {
				}
				0002 Fields {
					field 0001 0002 0003 0000 Attributes {
					}
					field 0002 0003 0004 0000 Attributes {
					}
				}
				0000 Methods {
				}
				0000 Attributes {
				}
			}
		''').assertNoErrors
	}

	@Test
	def void classFileWithTwoMethods() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0006 ConstantPool {
					utf8 01 ""
					utf8 01 ""
					utf8 01 ""
					utf8 01 ""
					class 07 0001
				}
				0001 0005 0005 0000 Interfaces {
				}
				0000 Fields {
				}
				0002 Methods {
					method 0001 0002 0003 0000 Attributes {
					}
					method 0002 0002 0003 0000 Attributes {
					}
				}
				0000 Attributes {
				}
			}
		''').assertNoErrors
	}

	@Test
	def void classFileWithUnknownAttributes() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0003 ConstantPool {
					utf8 01 ""
					class 07 0001
				}
				0001 0002 0002 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0002 Attributes {
					unknown 0001 00000000 Info { }
					unknown 0001 00000000 Info { }
				}
			}
		''').assertNoErrors
	}

	@Test
	def void classFileWithConstantValueAttribute() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0004 ConstantPool {
					utf8 01 ""
					integer 03 00000002
					class 07 0001
				}
				0001 0003 0003 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0001 Attributes {
					constantValue 0001 00000002 0002
				}
			}
		''').assertNoErrors
	}

	@Test
	def void classFileWithCodeAttribute() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0003 ConstantPool {
					utf8 01 ""
					class 07 0001
				}
				0001 0002 0002 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0001 Attributes {
					code 0001 0000000E 0003 0004 00000002 Code {
						nop 00
						nop 00
					} 0000 ExceptionTable {
					} 0000 Attributes {
					}
				}
			}
		''').assertNoErrors
	}

	@Test
	def void classFileWithCodeAttributeAndExceptionTableEntries() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0003 ConstantPool {
					utf8 01 ""
					class 07 0001
				}
				0001 0002 0002 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0001 Attributes {
					code 0001 0000001E 0003 0004 00000002 Code {
						nop 00
						nop 00
					} 0002 ExceptionTable {
						entry 0000 0001 0000 0002
						entry 0000 0001 0000 0002
					} 0000 Attributes {
					}
				}
			}
		''').assertNoErrors
	}

	@Test
	def void classFileWithCodeAttributeAndExceptionTableEntriesWithZeroReference() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0003 ConstantPool {
					utf8 01 ""
					class 07 0001
				}
				0001 0002 0002 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0001 Attributes {
					code 0001 0000001E 0003 0004 00000002 Code {
						nop 00
						nop 00
					} 0002 ExceptionTable {
						entry 0000 0001 0000 0000
						entry 0000 0001 0001 0000
					} 0000 Attributes {
					}
				}
			}
		''').assertNoErrors
	}

	@Test
	def void classFileWithCodeAttributeAndAttribute() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0004 ConstantPool {
					utf8 01 ""
					class 07 0001
					integer 03 00000002
				}
				0001 0002 0002 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0001 Attributes {
					code 0001 00000016 0003 0004 00000002 Code {
						nop 00
						nop 00
					} 0000 ExceptionTable {
					} 0001 Attributes {
						constantValue 0001 00000002 0003
					}
				}
			}
		''').assertNoErrors
	}

	@Test
	def void classFileWithSourceFileAttribute() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0003 ConstantPool {
					utf8 01 ""
					class 07 0001
				}
				0001 0002 0002 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0001 Attributes {
					sourceFile 0001 00000002 0001
				}
			}
		''').assertNoErrors
	}
	
	
	@Test
	def void classFileWithEnclosingMethodAttribute() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0004 ConstantPool {
					utf8 01 ""
					class 07 0001
					nameAndType 0C 0001 0001
				}
				0001 0002 0002 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0001 Attributes {
					enclosingMethod 0001 00000004 0002 0003
				}
			}
		''').assertNoErrors
	}
	

	@Test
	def void codeGotoOntoItself() {
		parse(standartClassFileWithCode('''
			goto a7 0000
		''')).assertNoErrors
	}

	@Test
	def void codeGotoEndOfMethod() {
		parse(standartClassFileWithCode('''
			aload_0 2A
			aload_1 2B
			if_acmpne A6 0007
			iconst_1 04
			goto A7 0004
			iconst_0 03
			ireturn AC
		''')).assertNoErrors
	}

	@Test
	def void codeGotoStartOfMethod() {
		parse(standartClassFileWithCode('''
			aload_0 2A
			aload_1 2B
			if_acmpne A6 0007
			iconst_1 04
			goto A7 8005
			iconst_0 03
			ireturn AC
		''')).assertNoErrors
	}

	@Test
	def void codeGetFStatic() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0008 ConstantPool {
					utf8 01 ""
					fieldRef 09 0003 0005
					class 07 0004
					utf8 01 "java/lang/System"
					nameAndType 0C 0006 0007
					utf8 01 "out"
					utf8 01 "Ljava/io/PrintStream;"
				}
				0001 0003 0003 0000 Interfaces {
				}
				0000 Fields {
				}
				0001 Methods {
					method 0009 0001 0001 0001 Attributes {
						code 0001 0000000F 0002 0001 00000003 Code {
							getstatic B2 0002
						} 0000 ExceptionTable {
						} 0000 Attributes {
						}
					}
				}
				0000 Attributes {
				}
			}
		''').assertNoErrors
	}

	@Test def void classFileWithLineNumberTableAttribute() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0003 ConstantPool {
					utf8 01 "LineNumberTable"
					class 07 0001
				}
				0001 0002 0002 0000 Interfaces {
				}
				0000 Fields {
				}
				0001 Methods {
					method 0009 0001 0001 0001 Attributes {
						code 0001 00000014 0002 0001 00000000 Code {
						} 0000 ExceptionTable {
						} 0001 Attributes {
							lineNumberTable 0001 00000002 0000 Table {
							}
						}
					}
				}
				0000 Attributes {
				}
			}
		''').assertNoErrors
	}

	@Test def void classFileWithLineNumberTableAttributeAndTwoEntries() {
		parse('''
			ClassFile {
				CAFEBABE 0001 0002 0003 ConstantPool {
					utf8 01 "LineNumberTable"
					class 07 0001
				}
				0001 0002 0002 0000 Interfaces {
				}
				0000 Fields {
				}
				0001 Methods {
					method 0009 0001 0001 0001 Attributes {
						code 0001 0000001E 0002 0001 00000002 Code {
							nop 00
							nop 00
						} 0000 ExceptionTable {
						} 0001 Attributes {
							lineNumberTable 0001 0000000A 0002 Table {
								lineNumber 0000 0005
								lineNumber 0001 0006
							}
						}
					}
				}
				0000 Attributes {
				}
			}
		''').assertNoErrors
	}

	private def standartClassFileWithCode(CharSequence code) {
		val codeString = code.toString().replaceAll("\r\n", "\n").replaceAll("\r", "\n")
		var cleanCode = ""
		for (instr : codeString.split("\n"))
			cleanCode += instr.substring(instr.indexOf(' '))
		cleanCode = cleanCode.replaceAll("\\s", '')
		val byteCount = cleanCode.length / 2
		return '''
			ClassFile {
				CAFEBABE 0001 0002 0003 ConstantPool {
					utf8 01 ""
					class 07 0001
				}
				0001 0002 0002 0000 Interfaces {
				}
				0000 Fields {
				}
				0000 Methods {
				}
				0001 Attributes {
					code 0001 �(byteCount + 12).u4Value� 0003 0004 �byteCount.u4Value� Code {
						�code�
					} 0000 ExceptionTable {
					} 0000 Attributes {
					}
				}
			}
		'''
	}

}
