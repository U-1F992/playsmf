Attribute VB_Name = "WindowsAPI"
Option Explicit

Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal ms As Long)

'�E�B���h�E�́ux�v�{�^���𖳌�������
Declare PtrSafe Function FindWindowA Lib "user32" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Declare PtrSafe Function DrawMenuBar Lib "user32" (ByVal hWnd As LongPtr) As Long
Declare PtrSafe Function GetSystemMenu Lib "user32" (ByVal hWnd As LongPtr, ByVal bRevert As Long) As Long
Declare PtrSafe Function DeleteMenu Lib "user32" (ByVal hMenu As LongPtr, ByVal nPosition As Long, ByVal wFlags As Long) As Long

'////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

'midiOutOpen => MIDI�f�o�C�X���J��
Declare PtrSafe Function midiOutOpen Lib "winmm" (lphMidiOut As LongPtr, ByVal uDeviceID As Long, ByVal dwCallback As Long, ByVal dwInstance As Long, ByVal dwFlags As Long) As Long
'<����>
'lphMidiOut�FMIDI�f�o�C�X�̃n���h��
'uDeviceID�F�f�o�C�XID = -1(MIDI�}�b�p�[)
'dwCallback�F�R�[���o�b�N�p�����[�^ = 0
'dwInstance�F�R�[���o�b�N�ɓn�����f�[�^ = 0
'dwFlags�F�R�[���o�b�N�t���O = 0
'<�߂�l>
'MMRESULT �G���[

'UINT midiOutOpen(
'  LPHMIDIOUT lphmo,
'  UINT uDeviceID,
'  DWORD dwCallback,
'  DWORD dwCallbackInstance,
'  DWORD dwFlags
');


'midiOutShortMsg => �V�X�e���G�N�X�N���[�V�u����уX�g���[�����b�Z�[�W�ȊO��MIDI���b�Z�[�W�𑗐M����
Declare PtrSafe Function midiOutShortMsg Lib "winmm" (ByVal hMidiOut As LongPtr, ByVal dwMsg As Long) As Long
'<����>
'hMidiOut�FMIDI�f�o�C�X�̃n���h��
'dwMsg�F���K
'��1�o�C�g... MIDI�X�e�[�^�X�o�C�g
'��2�o�C�g... MIDI�f�[�^1�o�C�g��
'��3�o�C�g... MIDI�f�[�^2�o�C�g��
'��4�o�C�g... �g�p����܂���
'<�߂�l>
'MMRESULT �G���[

'MMRESULT midiOutShortMsg(
'  HMIDIOUT hmo,
'  DWORD dwMsg
');

 
'midiOutReset => MIDI �o�̓f�o�C�X�̂��ׂẴ`�����l���̃m�[�g���I�t�ɂ���B
Declare PtrSafe Function midiOutReset Lib "winmm" (ByVal hMidiOut As LongPtr) As Long
'<����>
'hMidiOut�FMIDI�f�o�C�X�̃n���h��
'<�߂�l>
'MMRESULT �G���[

'MRESULT midiOutReset(
'    HMIDIOUT hmo   // MIDI�o�̓f�o�C�X�̃n���h��
');


'midiOutClose => MIDI�f�o�C�X�����
Declare PtrSafe Function midiOutClose Lib "winmm" (ByVal hMidiOut As LongPtr) As Long
'<����>
'hMidiOut�FMIDI�f�o�C�X�̃n���h��
'<�߂�l>
'MMRESULT �G���[

'MMRESULT midiOutClose(
'  hMidiOut hmo
');


'MIDIHDR�\����   4*6+10+������̒���(LenB)�o�C�g
Type MIDIHDR
    lpData          As LongPtr '���ۂ�MIDI�f�[�^
    dwBufferLength  As Long
    dwBytesRecorded As Long
    dwUser          As Long
    dwFlags         As Long
    lpNext          As Long
    Reserved        As Long
End Type
'lpData : MIDI �f�[�^���i�[�����o�b�t�@�̃A�h���X���i�[����܂�
'dwBufferLength : �f�[�^�o�b�t�@�̃T�C�Y���i�[����܂�
'dwBytesRecorded : �o�b�t�@���̎��ۂ̃f�[�^�T�C�Y���i�[����܂��B dwBufferLength �����o�Ŏw�肳�ꂽ�l�ȉ��łȂ���΂Ȃ�܂���
'dwUser : �J�X�^�����[�U�[�f�[�^���i�[����܂�
'dwFlags :�o�b�t�@�Ɋւ�����̃t���O���i�[����܂��B�K�� 0 �ɐݒ肷��
'lpNext : �g�p�s��
'Reserved : �g�p�s��
'dwOffset : �R�[���o�b�N�������̃o�b�t�@�̃I�t�Z�b�g���i�[����܂�
'dwReserved : �g�p�s��

'midiOutPrepareHeader => MIDI�V�X�e���r���o�b�t�@����������
Declare PtrSafe Function midiOutPrepareHeader Lib "winmm" (ByVal hmo As LongPtr, ByRef lpMidiOutHdr As MIDIHDR, ByVal cbMidiOutHdr As Long) As Long
'<����>
'hmo : MIDI �o�̓f�o�C�X�̃n���h�����w�肷��
'lpMidiOutHdr : ��������o�b�t�@�����ʂ���MIDIHDR�\���̂̃A�h���X���w�肷��
'cbMidiOutHdr : MIDIHDR �\���̂̃T�C�Y���o�C�g�P�ʂŎw�肷��
'<�߂�l>
'MMSYSERR�G���[
'
'lpData��MIDI�f�[�^���Z�b�g�AdwBufferLength�ɍ\���̃T�C�Y���Z�b�g�AdwFlags��0���Z�b�g���Ă���g��

'midiOutLongMsg =>�w�肳�ꂽ MIDI �o�̓f�o�C�X�ɃV�X�e���r�� MIDI ���b�Z�[�W�𑗐M����
Declare PtrSafe Function midiOutLongMsg Lib "winmm" (ByVal hmo As LongPtr, ByRef lpMidiOutHdr As MIDIHDR, ByVal cbMidiOutHdr As Long) As Long
'<����>
'hmo : MIDI�o�̓f�o�C�X�̃n���h�����w�肷��
'lpMidiOutHdr : MIDI�o�b�t�@�����ʂ���MIDIHDR�\���̂̃A�h���X���w�肷��B
'cbMidiOutHdr:  MIDIHDR�\���̂̃T�C�Y���o�C�g�P�ʂŎw�肷��

Declare PtrSafe Function midiOutUnprepareHeader Lib "winmm" (ByVal hmo As LongPtr, lpMidiOutHdr As MIDIHDR, ByVal cbMidiOutHdr As Long) As Long
'<����>
'hmo : MIDI �o�̓f�o�C�X�̃n���h�����w�肷��
'lpMidiOutHdr : �N���[���A�b�v����o�b�t�@�����ʂ���MIDIHDR�\���̂̃A�h���X���w�肷��
'cbMidiOutHdr : MIDIHDR �\���̂̃T�C�Y���o�C�g�P�ʂŎw�肷��
