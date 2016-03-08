%%
% Quick demonstration of Fourier decomposition in the context of speech sounds.
% I use this showing students how the sounds we hear as vowels are complex sounds which can be
% partially decomposed into constituent parts

%%
% Greenberg & Ainsworth (2004) pages 1-9: synopsis
% 
% In humans, the most important function of hearing is communication. How does the auditory system work? 
% Since the 1800?s, people have modeled the hearing system as a frequency analyzer. 
% Because each phone (or phoneme) can be decomposed using Fourier decomposition to a particular combination of sine waves, 
% and because each phone or phoneme is, in a sense, nothing more than that particular combination of sine waves, 
% all the auditory system really has to do is carry out a kind of Fourier analysis on the incoming speech sounds, one at a time, 
% and match these to a database of known sounds. This is known as *articulation theory*.
% But this is too simple a model of auditory processing. The auditory system is doing much more than this, 
% because in many situations (like a cocktail party), it would actually be less efficient to try to process the full spectrum
% of all the sounds heard. The system must be focussing on certain aspects of the speech signal. Other factors, 
% like an analysis of the modulation of intensity over time, are probably also very important tools for decoding speech sounds.
% 
% Different levels of speech analysis are very likely to correspond to different levels of the auditory stream, 
% from the cochlea to the entire brain. The auditory system is simultaneously doing many many things, 
% and most of the time we are not aware of any of it.  Humans' vocal apparatus is unlike any other animal's - apes, 
% our nearest relatives, cannot produce linguistic sounds. But, although our vocal tract has evolved dramatically, 
% our auditory systems are not that different than those of other mammals. This suggests that our ability to produce speech sounds, 
% and the speech sounds we make, have evolved to take advantage of the auditory capabilities that we already had (and share with
% many other mammals).
% 
% Ultimately, we would like to know how information is encoded in the speech signal, 
% and how the brain decodes that information. Furthermore, the authors point out that understanding the answers 
% to these questions may help us understand why human languages are the way they are.

%%
% path to a folder containing the documents 'vowel_a.wav' and 'vowel_i.wav'. These are two pre-recorded vowel sounds.
cd '/Users/ethan/Dropbox/Documents/Teaching/Courses/MA Workshops/Auditory Neuroscience and Speech Processing'
%%

clear all;
close all;

%%
% define a time window
t = 0:.001:.25;

%%
% make two sine waves
sine1 = sin(2*pi*50*t);
sine2 = sin(2*pi*120*t);
%%

figure; plot(t,sine1); xlabel('Seconds')
figure; plot(t,sine2); xlabel('Seconds')
%%

% Take a moment to figure out what the frequency of these sine waves is

% Hint: remember that frequency is measured in Hz.

%%
% play sine1
sound(sine1)
%%
% play sine2
sound(sine2)

%%

% build a complex sound by adding sine1 and sine2
complex_sound = sine1 + sine2;

%%

% Take a moment to think about what you might expect this wave to look like

%%

% plot complex_sound

figure; plot(t,complex_sound); xlabel('Seconds')

%%

% play complex_sound
sound(complex_sound)

%%

% add some random noise to complex_sound

noisy_sound = complex_sound + 2*randn(size(t));
figure; plot(noisy_sound(1:50))
title('Noisy time domain signal')

%%
sound(noisy_sound)

%%

Y = fft(noisy_sound,251);
Y2 = fft(complex_sound,251);

% for lots more about Fourier transforms, try here: 
% http://nautil.us/blog/the-math-trick-behind-mp3s-jpegs-and-homer-simpsons-face


%%

% Spectral density for complex_sound

% Compute the power spectral density, a measurement of the energy at various frequencies, using the complex conjugate (CONJ).
% Form a frequency axis for the first 127 points and use it to plot the result. (The remainder of the points are symmetric.)

Pyy = Y2.*conj(Y2)/251;
f = 1000/251*(0:127);
figure; plot(f,Pyy(1:128))
title('Power spectral density')
xlabel('Frequency (Hz)')

%%

% Spectral density for noisy_sound

% Compute the power spectral density, a measurement of the energy at various frequencies, using the complex conjugate (CONJ).
% Form a frequency axis for the first 127 points and use it to plot the result. (The remainder of the points are symmetric.)

Pyy = Y.*conj(Y)/251;
f = 1000/251*(0:127);
figure; plot(f,Pyy(1:128))
title('Power spectral density')
xlabel('Frequency (Hz)')

%%
% Zoom in to plot up to 200 Hz
figure; plot(f(1:50),Pyy(1:50))
title('Power spectral density')
xlabel('Frequency (Hz)')

%%
clear all
close all

%%

% Let's try with a *real* phoneme!

[Y_a, Fs_a] = audioread('vowel_a.wav');

%%

sound(Y_a, Fs_a);

%%

% Let's add another!

[Y_i, Fs_i] = audioread('vowel_i.wav');

%%

sound(Y_i, Fs_i);


%%
len = length(Y_a);
Y = fft(Y_a,len);

%%

% Spectral density for "a"

% Compute the power spectral density, a measurement of the energy at various frequencies, using the complex conjugate (CONJ).
% Form a frequency axis for the first 127 points and use it to plot the result. (The remainder of the points are symmetric.)

Pyy = Y_a.*conj(Y_a)/len;
f = 1000/len*(0:8000);
figure; plot(f,Pyy(1:8001)); 
title('Power spectral density')
xlabel('Frequency (Hz)')



%%
len_i = length(Y_i);
Y = fft(Y_i,len);

%%

% Spectral density for "i"

% Compute the power spectral density, a measurement of the energy at various frequencies, using the complex conjugate (CONJ).
% Form a frequency axis for the first 127 points and use it to plot the result. (The remainder of the points are symmetric.)

Pyy = Y_i.*conj(Y_i)/len_i;
f = 1000/len_i*(0:8000);
figure; plot(f,Pyy(1:8001));
title('Power spectral density')
xlabel('Frequency (Hz)')
