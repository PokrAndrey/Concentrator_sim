/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_gen2_0' in SOPC Builder design 'IP_DMA'
 * SOPC Builder design path: ../../IP_DMA.sopcinfo
 *
 * Generated: Mon May 16 12:35:17 GMT+03:00 2022
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00400820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x17
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00000020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x17
#define ALT_CPU_NAME "nios2_gen2_0"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00400820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x17
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00000020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x17
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00000000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_MSGDMA
#define __ALTERA_NIOS2_GEN2


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x401038
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x401038
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x401038
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "IP_DMA"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x401038
#define JTAG_UART_0_IRQ 1
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * msgdma_0_csr configuration
 *
 */

#define ALT_MODULE_CLASS_msgdma_0_csr altera_msgdma
#define MSGDMA_0_CSR_BASE 0x401000
#define MSGDMA_0_CSR_BURST_ENABLE 0
#define MSGDMA_0_CSR_BURST_WRAPPING_SUPPORT 0
#define MSGDMA_0_CSR_CHANNEL_ENABLE 0
#define MSGDMA_0_CSR_CHANNEL_ENABLE_DERIVED 0
#define MSGDMA_0_CSR_CHANNEL_WIDTH 8
#define MSGDMA_0_CSR_DATA_FIFO_DEPTH 32
#define MSGDMA_0_CSR_DATA_WIDTH 8
#define MSGDMA_0_CSR_DESCRIPTOR_FIFO_DEPTH 128
#define MSGDMA_0_CSR_DMA_MODE 2
#define MSGDMA_0_CSR_ENHANCED_FEATURES 0
#define MSGDMA_0_CSR_ERROR_ENABLE 0
#define MSGDMA_0_CSR_ERROR_ENABLE_DERIVED 0
#define MSGDMA_0_CSR_ERROR_WIDTH 8
#define MSGDMA_0_CSR_IRQ 0
#define MSGDMA_0_CSR_IRQ_INTERRUPT_CONTROLLER_ID 0
#define MSGDMA_0_CSR_MAX_BURST_COUNT 2
#define MSGDMA_0_CSR_MAX_BYTE 1024
#define MSGDMA_0_CSR_MAX_STRIDE 1
#define MSGDMA_0_CSR_NAME "/dev/msgdma_0_csr"
#define MSGDMA_0_CSR_PACKET_ENABLE 1
#define MSGDMA_0_CSR_PACKET_ENABLE_DERIVED 1
#define MSGDMA_0_CSR_PREFETCHER_ENABLE 0
#define MSGDMA_0_CSR_PROGRAMMABLE_BURST_ENABLE 0
#define MSGDMA_0_CSR_RESPONSE_PORT 2
#define MSGDMA_0_CSR_SPAN 32
#define MSGDMA_0_CSR_STRIDE_ENABLE 0
#define MSGDMA_0_CSR_STRIDE_ENABLE_DERIVED 0
#define MSGDMA_0_CSR_TRANSFER_TYPE "Aligned Accesses"
#define MSGDMA_0_CSR_TYPE "altera_msgdma"


/*
 * msgdma_0_descriptor_slave configuration
 *
 */

#define ALT_MODULE_CLASS_msgdma_0_descriptor_slave altera_msgdma
#define MSGDMA_0_DESCRIPTOR_SLAVE_BASE 0x401020
#define MSGDMA_0_DESCRIPTOR_SLAVE_BURST_ENABLE 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_BURST_WRAPPING_SUPPORT 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_CHANNEL_ENABLE 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_CHANNEL_ENABLE_DERIVED 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_CHANNEL_WIDTH 8
#define MSGDMA_0_DESCRIPTOR_SLAVE_DATA_FIFO_DEPTH 32
#define MSGDMA_0_DESCRIPTOR_SLAVE_DATA_WIDTH 8
#define MSGDMA_0_DESCRIPTOR_SLAVE_DESCRIPTOR_FIFO_DEPTH 128
#define MSGDMA_0_DESCRIPTOR_SLAVE_DMA_MODE 2
#define MSGDMA_0_DESCRIPTOR_SLAVE_ENHANCED_FEATURES 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_ERROR_ENABLE 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_ERROR_ENABLE_DERIVED 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_ERROR_WIDTH 8
#define MSGDMA_0_DESCRIPTOR_SLAVE_IRQ -1
#define MSGDMA_0_DESCRIPTOR_SLAVE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MSGDMA_0_DESCRIPTOR_SLAVE_MAX_BURST_COUNT 2
#define MSGDMA_0_DESCRIPTOR_SLAVE_MAX_BYTE 1024
#define MSGDMA_0_DESCRIPTOR_SLAVE_MAX_STRIDE 1
#define MSGDMA_0_DESCRIPTOR_SLAVE_NAME "/dev/msgdma_0_descriptor_slave"
#define MSGDMA_0_DESCRIPTOR_SLAVE_PACKET_ENABLE 1
#define MSGDMA_0_DESCRIPTOR_SLAVE_PACKET_ENABLE_DERIVED 1
#define MSGDMA_0_DESCRIPTOR_SLAVE_PREFETCHER_ENABLE 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_PROGRAMMABLE_BURST_ENABLE 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_RESPONSE_PORT 2
#define MSGDMA_0_DESCRIPTOR_SLAVE_SPAN 16
#define MSGDMA_0_DESCRIPTOR_SLAVE_STRIDE_ENABLE 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_STRIDE_ENABLE_DERIVED 0
#define MSGDMA_0_DESCRIPTOR_SLAVE_TRANSFER_TYPE "Aligned Accesses"
#define MSGDMA_0_DESCRIPTOR_SLAVE_TYPE "altera_msgdma"


/*
 * onchip_memory2_0 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2_0 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_0_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_0_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_0_BASE 0x0
#define ONCHIP_MEMORY2_0_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_0_DUAL_PORT 0
#define ONCHIP_MEMORY2_0_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_INIT_CONTENTS_FILE "IP_DMA_onchip_memory2_0"
#define ONCHIP_MEMORY2_0_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_0_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_0_IRQ -1
#define ONCHIP_MEMORY2_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_0_NAME "/dev/onchip_memory2_0"
#define ONCHIP_MEMORY2_0_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_0_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_0_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_0_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_0_SIZE_VALUE 65536
#define ONCHIP_MEMORY2_0_SPAN 65536
#define ONCHIP_MEMORY2_0_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_0_WRITABLE 1


/*
 * sysid_qsys_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_qsys_0 altera_avalon_sysid_qsys
#define SYSID_QSYS_0_BASE 0x401030
#define SYSID_QSYS_0_ID 305419896
#define SYSID_QSYS_0_IRQ -1
#define SYSID_QSYS_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_QSYS_0_NAME "/dev/sysid_qsys_0"
#define SYSID_QSYS_0_SPAN 8
#define SYSID_QSYS_0_TIMESTAMP 1652692383
#define SYSID_QSYS_0_TYPE "altera_avalon_sysid_qsys"

#endif /* __SYSTEM_H_ */
