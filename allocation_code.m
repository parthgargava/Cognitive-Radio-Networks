    clc
    close all
    clear all
    
    t = 0:0.00001:0.001;
    F1 = 1000;
    F2 = 2000;
    F3 = 3000;
    F4 = 4000;
    F5 = 5000;
    Fs = 12000;
    
    a1 = 1; a2 = 0; a3 = 0; a4 = 0; a5 = 0; A = 0; a = 0;
    
    x = cos(2*pi*1000*t);
  
    in_p = input('\nDo you want to enter first primary user Y/N:  ','s');
   
    
    if(in_p == 'Y' | in_p == 'y')
        a1 = ammod(x,F1,Fs);
        
    end
    
    in_p = input('Do you want to enter second primary user Y/N:  ','s');
    
    if(in_p == 'Y' | in_p == 'y')
        a2 = ammod(x,F2,Fs);
    
    end
        
    in_p = input('Do you want to enter third primary user Y/N:  ','s');

    if(in_p == 'Y' | in_p == 'y')
        a3 = ammod(x,F3,Fs);
       
    end

    in_p = input('Do you want to enter fourth primary user Y/N:  ','s');

    if(in_p == 'Y' | in_p == 'y')
        a4 = ammod(x,F4,Fs);
    
    end

    in_p = input('Do you want to enter fifth primary user Y/N:  ','s');
    
    if(in_p == 'Y' | in_p == 'y')
        a5 = ammod(x,F5,Fs);
        
    end
    
    a = a1 + a2 + a3 + a4 + a5;
    
while(1)
    
        Pxx = periodogram(a);
        Hpsd = dspdata.psd(Pxx,'Fs',Fs);
        plot(Hpsd);
    
        
  in_p = input('\nDo you want to enter a secondary user Y/N:  ','s');
 
    if(in_p == 'Y' | in_p == 'y')
    
        
    
        tp=0;
        c1 = Pxx(25)*10000 ;
        c2 = Pxx(46)*10000 ;
        c3 = Pxx(62)*10000 ;
        c4 = Pxx(89)*10000 ;
        c5 = Pxx(105)*10000 ;
       
        
        gamma=8000;
        
        
        if(c1 < gamma)
            disp('Assigned to User 1 as it was not present.');
            a1 = ammod(x,F1,Fs);
    

    elseif (c2 < gamma)
            disp('Assigned to User 2 as it was not present.');
            a2 = ammod(x,F2,Fs);
        
    
        elseif(c3 < gamma)
            disp('Assigned to User 3 as it was not present.');
            a3 = ammod(x,F3,Fs);
        
    
        elseif(c4 < gamma)
            disp('Assigned to User 4 as it was not present.');
            a4 = ammod(x,F4,Fs);
        

        elseif(c5 < gamma)
            disp('Assigned to User 5 as it was not present.');
            a5 = ammod(x,F5,Fs);
        else
            disp('all user slots in use. try again later,');
            tp=1;
        end
        
        figure
        a = a1 + a2 + a3 + a4 + a5 ;
        Pxx = periodogram(a);                   
        Hpsd = dspdata.psd(Pxx,'Fs',Fs);
        plot(Hpsd);
         
         %,,,,,,,,,,,slot empty operation,,,,,,,,,,,,,,
        if(tp==1)
        inp_t=input('do u want to empty a slot:     ','s');
        if(inp_t=='Y'|inp_t=='y')
            inp_t=input('which slot do u want to empty for ur entry:     ','s');
            switch(inp_t)
                
                case ('1')
                    a1=0;
                    disp('slot1 is fired');
                    a = a1 + a2 + a3 + a4 + a5;
                    Pxx = periodogram(a);                   
                    Hpsd = dspdata.psd(Pxx,'Fs',Fs);
                    plot(Hpsd);
                    %break;
                
                case('2')
                    a2=0;
                    disp('slot2 is fired');
                    a = a1 + a2 + a3 + a4 + a5;    
                    Pxx = periodogram(a);
                    Hpsd = dspdata.psd(Pxx,'Fs',Fs);
                    plot(Hpsd);
                    %break;
                
                case('3')
                    a3=0;
                    disp('slot3 is fired');
                    a = a1 + a2 + a3 + a4 + a5;
                    Pxx = periodogram(a);
                    Hpsd = dspdata.psd(Pxx,'Fs',Fs);
                    plot(Hpsd);
                    %break;
                
                case('4')
                    a4=0;
                    disp('slot4 is fired');
                    a = a1 + a2 + a3 + a4 + a5;
                    Pxx = periodogram(a);
                    Hpsd = dspdata.psd(Pxx,'Fs',Fs);
                    plot(Hpsd);
                    %break;
                
                case('5')
                     a5=0;
                    disp('slot5 is fired');
                    a = a1 + a2 + a3 + a4 + a5;
                    Pxx = periodogram(a);
                    Hpsd = dspdata.psd(Pxx,'Fs',Fs);
                    plot(Hpsd);
                    %break;
                
                otherwise disp('invalid slot entered');
                   %break;
            end  %switch end
        end
        end
        %////////////////////Adding Noise////////////////////
        inp_t=input('do u want to add noise(y / n): ','s');
        if(inp_t=='y'|inp_t=='Y')
        d = input('Enter the SNR in dB:   ');
        figure
        A = awgn(a,d);
        Pxx1 = periodogram(A);
        Hpsd = dspdata.psd(Pxx1,'Fs',Fs);
        plot(Hpsd);
        disp('adding noise');
        
        c1 = Pxx1(25).*10000;
        c2 = Pxx1(49).*10000;
        c3 = Pxx1(62).*10000;
        c4 = Pxx1(89).*10000;
        c5 = Pxx1(105).*10000;

        if(c1 < gamma)
            disp('User 1 is not present.');
        else
            disp('User 1 is present.');
        end

        if(c2 < gamma)
            disp('User 2 is not present.');
            else
            disp('User 2 is present.');
        end

        if(c3 < gamma)
            disp('User 3 is not present.');
            else
            disp('User 3 is present.');
        end

        if(c4 < gamma)
            disp('User 4 is not present.');
            else
            disp('User 4 is present.');
        end

        if(c5 < gamma)
            disp('User 5 is not present.');
        else
            disp('User 5 is present.');
        end
        
        end
        
     end
    
    %if rerun the program
    
    temp = input('Do you want to re-run the program? [Y/N]:    ','s');
    
     if(temp == 'Y' | temp == 'y')
         disp('\n\nEnter the users again.\n\n');
     else
         break;
     end
end
