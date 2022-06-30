#include "stdio.h"
#include "system.h"
//#include "altera_avalon_pio_regs.h"
#include "sys/alt_stdio.h"
#include <altera_msgdma.h>
#include <altera_msgdma_descriptor_regs.h>
#include <string.h>

int main ()
{
    char leds = 0x1;
    int big_leds = 0x0;
    int i = 0;
    char* array = malloc(sizeof(char)*20);
    alt_u32 k = 0;
    alt_u32 base_offset = 0;

    while (1)
    {

      base_offset = k & 128;
      // Остановили процесс, чтобы всё понастраивать
      IOWR_ALTERA_MSGDMA_CSR_CONTROL(MSGDMA_0_CSR_BASE,
          ALTERA_MSGDMA_CSR_STOP_DESCRIPTORS_MASK);
      // На самом деле, тут должно быть ожидание фактической остановки,
      // но в рамках теста, оно не нужно. Точно остановимся.
      // Добавляем дескриптор в FIFO
      IOWR_ALTERA_MSGDMA_DESCRIPTOR_READ_ADDRESS(MSGDMA_0_DESCRIPTOR_SLAVE_BASE,
          (alt_u32)0);
      IOWR_ALTERA_MSGDMA_DESCRIPTOR_WRITE_ADDRESS(MSGDMA_0_DESCRIPTOR_SLAVE_BASE,
          (alt_u32)ONCHIP_MEMORY2_0_BASE + base_offset /*+ array*/);
      IOWR_ALTERA_MSGDMA_DESCRIPTOR_LENGTH(MSGDMA_0_DESCRIPTOR_SLAVE_BASE,
    		  (alt_u32)7);
      IOWR_ALTERA_MSGDMA_DESCRIPTOR_CONTROL_STANDARD(MSGDMA_0_DESCRIPTOR_SLAVE_BASE,
          ALTERA_MSGDMA_DESCRIPTOR_CONTROL_GO_MASK);

      volatile alt_u32 status = IORD_ALTERA_MSGDMA_CSR_STATUS(MSGDMA_0_CSR_BASE);
       // Запустили процесс, не забыв отключить прерывания
       IOWR_ALTERA_MSGDMA_CSR_CONTROL(MSGDMA_0_CSR_BASE,
           ALTERA_MSGDMA_CSR_STOP_ON_ERROR_MASK
           & (~ALTERA_MSGDMA_CSR_STOP_DESCRIPTORS_MASK)
           &(~ALTERA_MSGDMA_CSR_GLOBAL_INTERRUPT_MASK)) ;

       // Ждём конца передачи
       static const alt_u32 errMask = ALTERA_MSGDMA_CSR_STOPPED_ON_ERROR_MASK |
               ALTERA_MSGDMA_CSR_STOPPED_ON_EARLY_TERMINATION_MASK |
               ALTERA_MSGDMA_CSR_STOP_STATE_MASK |
               ALTERA_MSGDMA_CSR_RESET_STATE_MASK;
      status = IORD_ALTERA_MSGDMA_CSR_STATUS(MSGDMA_0_CSR_BASE);

      do
        {
           status = IORD_ALTERA_MSGDMA_CSR_STATUS(MSGDMA_0_CSR_BASE);
        } while (!(status & errMask) &&(status & ALTERA_MSGDMA_CSR_BUSY_MASK));

        //alt_putstr("You can play with memory!\n");
      k = ~k;

        /*IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, big_leds);
        for (i=0; i<(ALT_CPU_CPU_FREQ/500); i++);    // Delay
        // Johnson code counter on leds
        leds = ((leds<<1) & 0xE) | (!(leds>>3) & 0x1);
        big_leds = leds & 0x000000FF;
    	printf ("big_leds = %d\n", big_leds);*/
    }
    return 0;
}
