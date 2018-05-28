function[Ix,Iy,Iz,prn,satnum,maxnum,fw,pw,EWL,FC,pc]=SD(OBSprn,BASEprn,obsnum,xus,yus,zus,Utheta,basenum,x0,EWLb,EWLu,Base,User)
satnum=0;
for  i=1:obsnum
    for  j=1:basenum
        if(OBSprn(i)==BASEprn(j))
            satnum=satnum+1;
            r=sqrt((xus(i)-x0(1))^2+(yus(i)-x0(2))^2+(zus(i)-x0(3))^2);
            Ix(satnum) = (xus(i) - x0(1))/r;
            Iy(satnum) = (yus(i) - x0(2))/r;
            Iz(satnum) = (zus(i) - x0(3))/r;
            Utheta1(satnum)=Utheta(i);
            fw(satnum) = 0.005^2*(1+(1/Utheta1(satnum)^2));
            pw(satnum) = 0.5^2*(1+(1/Utheta1(satnum)^2));
            prn(satnum)= OBSprn(i);
            
            % �����α�ࡢ�ز��۲���
            FC(satnum)=User.FCu1(i)-Base.FCb1(j); 
            pc(satnum)=User.pcu1(i)-Base.pcb1(j);
            
%% ������α�ࡢ�ز��۲���           
            EWL.FC1(satnum)=EWLu.FCu1(i)-EWLb.FCb1(j);
            EWL.pc1(satnum)=EWLu.pcu1(i)-EWLb.pcb1(j);
            
            EWL.FC2(satnum)=EWLu.FCu2(i)-EWLb.FCb2(j);
            EWL.pc2(satnum)=EWLu.pcu2(i)-EWLb.pcb2(j);
            
            EWL.FC3(satnum)=EWLu.FCu3(i)-EWLb.FCb3(j);
            EWL.pc3(satnum)=EWLu.pcu3(i)-EWLb.pcb3(j);
            

            
            
            break;
        end
    end
    
end
thet=0;
for i1=1:satnum
    if(Utheta1(i1)>thet)
        maxnum=i1;
        thet=Utheta1(i1);
    end
end
end