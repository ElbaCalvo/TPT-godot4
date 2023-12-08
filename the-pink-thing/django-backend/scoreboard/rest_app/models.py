from django.db import models

class Score(models.Model):
	id = models.AutoField(primary_key=True, editable=False)
	username = models.CharField(max_length=50)
	score = models.IntegerField()

	def __str__(self):
		return self.username + self.score
