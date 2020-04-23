*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = '警告' ;

length I_BAD $ 12;
label I_BAD = '到: BAD' ;
*** Target Values;
array REGDRF [2] $12 _temporary_ ('1' '0' );
label U_BAD = '非正规化至: BAD' ;
*** Unnormalized target values;
ARRAY REGDRU[2]  _TEMPORARY_ (1 0);

drop _DM_BAD;
_DM_BAD=0;

*** Check CLAGE for missing values ;
if missing( CLAGE ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check CLNO for missing values ;
if missing( CLNO ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check DEBTINC for missing values ;
if missing( DEBTINC ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check DELINQ for missing values ;
if missing( DELINQ ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check DEROG for missing values ;
if missing( DEROG ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check LOAN for missing values ;
if missing( LOAN ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check MORTDUE for missing values ;
if missing( MORTDUE ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check NINQ for missing values ;
if missing( NINQ ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check VALUE for missing values ;
if missing( VALUE ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check YOJ for missing values ;
if missing( YOJ ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for JOB ;
drop _1_0 _1_1 _1_2 _1_3 _1_4 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
_1_4 = 0;
if missing( JOB ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
   _1_4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   %DMNORMCP( JOB , _dm7 )
   _dm_find = 0; drop _dm_find;
   if _dm7 <= 'OTHER'  then do;
      if _dm7 <= 'OFFICE'  then do;
         if _dm7 = 'MGR'  then do;
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm7 = 'OFFICE'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm7 = 'OTHER'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm7 <= 'SALES'  then do;
         if _dm7 = 'PROFEXE'  then do;
            _1_3 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm7 = 'SALES'  then do;
               _1_4 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm7 = 'SELF'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _1_4 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      _1_4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REASON ;
drop _2_0 ;
if missing( REASON ) then do;
   _2_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   %DMNORMCP( REASON , _dm7 )
   if _dm7 = 'DEBTCON'  then do;
      _2_0 = 1;
   end;
   else if _dm7 = 'HOMEIMP'  then do;
      _2_0 = -1;
   end;
   else do;
      _2_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.0870195794;
   _P1 = 0.9129804206;
   goto REGDR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: CLAGE ;
_TEMP = CLAGE ;
_LP0 = _LP0 + (   -0.00235907077242 * _TEMP);

***  Effect: CLNO ;
_TEMP = CLNO ;
_LP0 = _LP0 + (   -0.02412991177577 * _TEMP);

***  Effect: DEBTINC ;
_TEMP = DEBTINC ;
_LP0 = _LP0 + (    0.08414276109463 * _TEMP);

***  Effect: DELINQ ;
_TEMP = DELINQ ;
_LP0 = _LP0 + (    0.80102002515387 * _TEMP);

***  Effect: DEROG ;
_TEMP = DEROG ;
_LP0 = _LP0 + (    0.73753114928331 * _TEMP);

***  Effect: JOB ;
_TEMP = 1;
_LP0 = _LP0 + (    0.66797170415239) * _TEMP * _1_0;
_LP0 = _LP0 + (    0.08963574344466) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.39477722616181) * _TEMP * _1_2;
_LP0 = _LP0 + (    0.08526260808589) * _TEMP * _1_3;
_LP0 = _LP0 + (   -1.66216669587307) * _TEMP * _1_4;

***  Effect: LOAN ;
_TEMP = LOAN ;
_LP0 = _LP0 + (   -0.00001350413535 * _TEMP);

***  Effect: MORTDUE ;
_TEMP = MORTDUE ;
_LP0 = _LP0 + ( -5.3168761456492E-6 * _TEMP);

***  Effect: NINQ ;
_TEMP = NINQ ;
_LP0 = _LP0 + (    0.26839004706282 * _TEMP);

***  Effect: REASON ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.13407888164937) * _TEMP * _2_0;

***  Effect: VALUE ;
_TEMP = VALUE ;
_LP0 = _LP0 + (  2.2589409081148E-6 * _TEMP);

***  Effect: YOJ ;
_TEMP = YOJ ;
_LP0 = _LP0 + (   -0.03119607452579 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =     -4.9731182023003 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REGDR1:


*** Posterior Probabilities and Predicted Level;
label P_BAD1 = '预测: BAD=1' ;
label P_BAD0 = '预测: BAD=0' ;
P_BAD1 = _P0;
_MAXP = _P0;
_IY = 1;
P_BAD0 = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
I_BAD = REGDRF[_IY];
U_BAD = REGDRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
