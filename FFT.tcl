# SimVision command script dice.tcl


simvision {

  window new WaveWindow  -name  "Waves for dice"
  waveform  using  "Waves for dice"

 # Probe primary I/O

    waveform  add  -signals  FFT_stim.Clock
    waveform  add  -signals  FFT_stim.FFT.clk
    waveform  add  -signals  FFT_stim.nReset
    waveform  add  -signals  FFT_stim.sw
    waveform  add  -signals  FFT_stim.ReadyIn
    waveform  add  -signals  FFT_stim.FFT.datapath.regs.state
    waveform  add  -signals  FFT_stim.FFT.datapath.regs.Rew
    waveform  add  -signals  FFT_stim.FFT.datapath.regs.Imw
    waveform  add  -signals  FFT_stim.FFT.datapath.regs.Reb
    waveform  add  -signals  FFT_stim.FFT.datapath.regs.Imb
    waveform  add  -signals  FFT_stim.FFT.datapath.regs.Rea
    waveform  add  -signals  FFT_stim.FFT.datapath.regs.Ima

    waveform  add  -signals  FFT_stim.FFT.c0.state
    waveform  add  -signals  FFT_stim.FFT.c0.load_Rew
    waveform  add  -signals  FFT_stim.FFT.c0.load_Imw
    waveform  add  -signals  FFT_stim.FFT.c0.load_Reb
    waveform  add  -signals  FFT_stim.FFT.c0.load_Imb
    waveform  add  -signals  FFT_stim.FFT.c0.load_Rea
    waveform  add  -signals  FFT_stim.FFT.c0.load_Ima

    waveform  add  -signals  FFT_stim.FFT.datapath.m1.REb
    waveform  add  -signals  FFT_stim.FFT.datapath.m1.IMb
    waveform  add  -signals  FFT_stim.FFT.datapath.m1.REw
    waveform  add  -signals  FFT_stim.FFT.datapath.m1.IMw
    waveform  add  -signals  FFT_stim.FFT.datapath.m1.nMUL1
    waveform  add  -signals  FFT_stim.FFT.datapath.m1.nMUL2
    waveform  add  -signals  FFT_stim.FFT.datapath.m2.REB
    waveform  add  -signals  FFT_stim.FFT.datapath.m2.IMB
    waveform  add  -signals  FFT_stim.FFT.datapath.m2.REW
    waveform  add  -signals  FFT_stim.FFT.datapath.m2.IMW
    waveform  add  -signals  FFT_stim.FFT.datapath.m2.nMUL3
    waveform  add  -signals  FFT_stim.FFT.datapath.m2.nMUL4

    waveform  add  -signals  FFT_stim.FFT.datapath.m0.mul_en
    waveform  add  -signals  FFT_stim.FFT.datapath.m0.mul1
    waveform  add  -signals  FFT_stim.FFT.datapath.m0.mul2
    waveform  add  -signals  FFT_stim.FFT.datapath.m0.mul3
    waveform  add  -signals  FFT_stim.FFT.datapath.m0.mul4
    waveform  add  -signals  FFT_stim.FFT.datapath.m0.in_a
    waveform  add  -signals  FFT_stim.FFT.datapath.m0.in_b
    waveform  add  -signals  FFT_stim.FFT.datapath.m0.out
    waveform  add  -signals  FFT_stim.FFT.datapath.m0.RE
    waveform  add  -signals  FFT_stim.FFT.datapath.m0.IM
    waveform  add  -signals  FFT_stim.FFT.datapath.m0.state
    
    waveform  add  -signals  FFT_stim.FFT.datapath.ca0.state
    waveform  add  -signals  FFT_stim.FFT.datapath.ca0.cal_en
    waveform  add  -signals  FFT_stim.FFT.datapath.ca0.RE
    waveform  add  -signals  FFT_stim.FFT.datapath.ca0.IM
    waveform  add  -signals  FFT_stim.FFT.datapath.ca0.in_a
    waveform  add  -signals  FFT_stim.FFT.datapath.ca0.in_b
    waveform  add  -signals  FFT_stim.FFT.datapath.ca0.out
    waveform  add  -signals  FFT_stim.FFT.datapath.ca0.p_r
    waveform  add  -signals  FFT_stim.FFT.datapath.ca0.op

    waveform  add  -signals  FFT_stim.FFT.datapath.d0.display_Rey
    waveform  add  -signals  FFT_stim.FFT.datapath.d0.Rey
    waveform  add  -signals  FFT_stim.FFT.datapath.d0.display_Imy
    waveform  add  -signals  FFT_stim.FFT.datapath.d0.Imy
    waveform  add  -signals  FFT_stim.FFT.datapath.d0.display_Rez
    waveform  add  -signals  FFT_stim.FFT.datapath.d0.Rez
    waveform  add  -signals  FFT_stim.FFT.datapath.d0.display_Imz
    waveform  add  -signals  FFT_stim.FFT.datapath.d0.Imz
    waveform  add  -signals  FFT_stim.FFT.datapath.d0.LED
    
    








}




