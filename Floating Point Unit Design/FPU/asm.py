from __future__ import print_function


cop1="010001"
lui="001111"
ori="001101"

add="000000"
sub="000001"
mul="000010"
div="000011"
cvtps="100110"
cvts="100000"
cvtw="100100"
cvtspl="101000"
cvtspu="100000"


fmt_s="10000"
fmt_ps="10110"
fmt_w="10100"
fmt_pu="10110"

with open("sti","w") as sti:
	print("@00000000",file=sti)

with open("sti","a") as sti:
    with open("instr.s") as file:
        instrs=file.read().splitlines()
        for i in range(len(instrs)):
            ins=instrs[i].split()
            #print(ins)
            if ins[0]=='lui':
                op=lui
                fmt="00000"
                middle=''.join(ins[1].split(","))
                mc=op+fmt+middle
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='ori':
                op=ori
                temp=ins[1].split(",")
                temp[0],temp[1]=temp[1],temp[0]
                middle=''.join(temp)
                mc=op+middle
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='add.s':
                op=cop1
                fmt=fmt_s
                middle=''.join(reversed(ins[1].split(",")))
                func=add
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='add.ps':
                op=cop1
                fmt=fmt_ps
                middle=''.join(reversed(ins[1].split(",")))
                func=add
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='sub.s':
                op=cop1
                fmt=fmt_s
                middle=''.join(reversed(ins[1].split(",")))
                func=sub
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='sub.ps':
                op=cop1
                fmt=fmt_ps
                middle=''.join(reversed(ins[1].split(",")))
                func=sub
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='mul.s':
                op=cop1
                fmt=fmt_s
                middle=''.join(reversed(ins[1].split(",")))
                func=mul
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='mul.ps':
                op=cop1
                fmt=fmt_ps
                middle=''.join(reversed(ins[1].split(",")))
                func=mul
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='div.s':
                op=cop1
                fmt=fmt_s
                middle=''.join(reversed(ins[1].split(",")))
                func=div
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='cvt.ps.s':
                op=cop1
                fmt=fmt_s
                middle=''.join(reversed(ins[1].split(",")))
                func=cvtps
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='cvt.s.w':
                op=cop1
                fmt=fmt_w
                middle="00000"+''.join(reversed(ins[1].split(",")))
                func=cvts
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='cvt.w.s':
                op=cop1
                fmt=fmt_s
                middle="00000"+''.join(reversed(ins[1].split(",")))
                func=cvtw
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='cvt.s.pl':
                op=cop1
                fmt="10110"
                middle="00000"+''.join(reversed(ins[1].split(",")))
                func=cvtspl
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='cvt.s.pu':
                op=cop1
                fmt="10110"
                middle="00000"+''.join(reversed(ins[1].split(",")))
                func=cvtspu
                mc=op+fmt+middle+func
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='mfc1':
                op=cop1
                mf="00000"
                middle=''.join(ins[1].split(","))
                last="00000000000"
                mc=op+mf+middle+last
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            elif ins[0]=='mtc1':
                op=cop1
                mf="00100"
                middle=''.join(ins[1].split(","))
                last="00000000000"
                mc=op+mf+middle+last
                mc_16=str(hex(int(mc,2)))[2:]
                print(mc_16,file=sti)
            else:
                print("00000000",file=sti)