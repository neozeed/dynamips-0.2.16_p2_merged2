CC = gcc
CFLAGS =	-I.. -Os -g -DJIT_ARCH=\"x86\" -DJIT_CPU=CPU_x86 -DMIPS64_ARCH_INC_FILE=\"mips64_x86_trans.h\" 
CFLAGS +=	-DPPC32_ARCH_INC_FILE=\"ppc32_x86_trans.h\" 
CFLAGS +=	-DDYNAMIPS_VERSION=\"0.2.16-experimental\(merge\ uppc\ smips\)Build-1\" 
CFLAGS +=	-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -DHAS_RFC2553=0 
CFLAGS +=	-DHAS_POSIX_MEMALIGN=1 -D_FILE_OFFSET_BITS=64 -DOSNAME=MinGW -DGEN_ETH

LIBS= -lpthread -lws2_32 -lwsock32 -static-libgcc -static
LIBS += -L../libelf-0.8.13/lib/ -lelf
LIBS += ..\drmingw-0.8.0-win32\lib\libexchndl.a

MIPSMICROCODE = mips64_microcode_dump.inc
PPCMICROCODE = ppc32_microcode_dump.inc
MICROCODE =  $(MIPSMICROCODE)  $(PPCMICROCODE)

OBJ =	mempool.o registry.o rbtree.o hash.o sbox.o utils.o parser.o \
	plugin.o ptask.o timer.o crc.o base64.o \
	net.o net_io.o net_io_bridge.o net_io_filter.o \
	atm.o atm_vsar.o atm_bridge.o frame_relay.o eth_switch.o \
	dynamips.o insn_lookup.o vm.o cpu.o jit_op.o \
	mips64.o mips64_mem.o mips64_cp0.o mips64_jit.o mips64_exec.o \
	ppc32.o ppc32_mem.o ppc32_jit.o ppc32_exec.o ppc32_vmtest.o \
	memory.o device.o nmc93cX6.o cisco_eeprom.o cisco_card.o \
	pci_dev.o pci_io.o \
	dev_zero.o dev_bswap.o old_dev_vtty.o dev_ram.o dev_rom.o dev_nvram.o \
	dev_bootflash.o dev_flash.o dev_mpc860.o dev_ds1620.o \
	dev_remote.o dev_clpd6729.o dev_pcmcia_disk.o dev_gt.o dev_mv64460.o \
	dev_plx.o dev_dec21x50.o dev_pericom.o dev_ti2050b.o dev_ap1011.o \
	dev_plx6520cb.o dev_ns16552.o \
	dev_dec21140.o dev_am79c971.o dev_i8254x.o dev_i8255x.o \
	dev_mueslix.o dev_wic_serial.o \
	dev_c3600.o dev_c3600_bay.o dev_c3600_iofpga.o \
	dev_c3600_eth.o dev_c3600_serial.o \
	dev_c7200.o dev_c7200_iofpga.o dev_c7200_mpfpga.o \
	dev_c7200_sram.o dev_c7200_eth.o dev_c7200_serial.o dev_c7200_pos.o \
	dev_c7200_bri.o dev_c7200_jcpa.o \
	dev_c2691.o dev_c2691_iofpga.o dev_c2691_eth.o dev_c2691_serial.o \
	dev_c2691_wic.o dev_c2691_pcmod.o \
	dev_c3725.o dev_c3725_iofpga.o dev_c3725_eth.o dev_c3725_serial.o \
	dev_c3725_wic.o dev_c3725_pcmod.o \
	dev_c3745.o dev_c3745_iofpga.o dev_c3745_eth.o dev_c3745_serial.o \
	dev_c3745_wic.o dev_c3745_pcmod.o \
	dev_c2600.o dev_c2600_pci.o dev_c2600_iofpga.o \
	dev_c2600_eth.o dev_c2600_pcmod.o dev_c2600_wic.o \
	dev_c1700.o dev_c1700_iofpga.o dev_c1700_eth.o dev_c1700_wic.o \
	dev_c6msfc1.o dev_c6msfc1_iofpga.o dev_c6msfc1_mpfpga.o \
	dev_c6sup1.o dev_c6sup1_iofpga.o dev_c6sup1_mpfpga.o \
	dev_nm_16esw.o dev_pa_a1.o dev_pa_mc8te1.o \
	dev_sb1.o dev_sb1_io.o dev_sb1_pci.o hypervisor.o \
	hv_nio.o hv_nio_bridge.o \
	hv_frsw.o hv_atmsw.o hv_atm_bridge.o hv_ethsw.o \
	hv_vm.o hv_vm_debug.o hv_store.o \
	hv_c7200.o hv_c3600.o hv_c2691.o hv_c3725.o hv_c3745.o \
	hv_c2600.o hv_c1700.o \
	rommon_var.o get_cpu_time.o \
	fs_mbr.o fs_fat.o fs_nvram.o \
	tcb.o \
	inet_aton.o sendrecv.o mman.o fsync.o usleep.o localtime_r.o

OBJ += gen_eth.o mips64_x86_trans.o ppc32_x86_trans.o

default: dynamips

rom2c: 
	@echo "Linking $@"
	$(CC) ..\rom2c.c -o rom2c.exe -I.. -L../libelf-0.8.13/lib/ -lelf

dynamips: $(MICROCODE) $(OBJ)
	$(CC) $(OBJ) $(LIBS) -o dynamips

mips64_microcode_dump.inc: rom2c 
	./rom2c ..\microcode\mips64_test mips64_microcode_dump.inc 0xbfc00000

ppc32_microcode_dump.inc: rom2c
	./rom2c ..\microcode\ppc32_test2 ppc32_microcode_dump.inc 0xfff00000

%.o: ../%.c
	$(CC) $(CFLAGS) $(INCLUDE) -c -o $*.o $<


dev_rom.o: $(MICROCODE)

clean:
	rm -f $(MICROCODE)
	rm -f $(OBJ)
	rm -f dynamips.exe rom2c.exe
